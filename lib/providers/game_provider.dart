import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'game_settings_provider.dart';

part 'game_provider.g.dart';

@riverpod
class Game extends _$Game {
  int _order = 1;

  @override
  Map<String, dynamic> build() {
    final gameSettings = ref.read(gameSettingsProvider);

    return {
      "board": List.generate(
        gameSettings["boardSize"],
        (index) => List.generate(
          gameSettings["boardSize"],
          (i) => {"mark": "", "colorInt": Colors.black.value, "order": ""},
        ),
      ),
      "isEnd": false,
      "lastPosition": [],
      "restoreCount": {
        "player1": 3,
        "player2": 3,
      },
      "lastPlayer": "",
    };
  }

  void addMark(
    int columnIndex,
    int rowIndex,
    String mark,
    MaterialColor color,
    String player,
  ) {
    List<List<Map<String, Object>>> board = state["board"];

    board[columnIndex][rowIndex] = {
      "mark": mark,
      "colorInt": color.value,
      "order": "$_order",
    };
    _order++;

    final hasWinner = _checkGame(columnIndex, rowIndex, board, mark);
    final isEnd =
        board.every((item) => item.every((value) => value["mark"] != "")) ||
            hasWinner;

    state = {
      ...state,
      "board": board,
      "lastPosition": [columnIndex, rowIndex],
      "isEnd": isEnd,
      "lastPlayer": hasWinner ? player : "",
    };
  }

  void restore(String player) {
    List board = state["board"];
    final indexGroup = state["lastPosition"];

    board[indexGroup[0]][indexGroup[1]] = {
      "mark": "",
      "colorInt": Colors.black.value,
      "order": "",
    };

    state = {
      ...state,
      "board": board,
      "lastPosition": [],
      "restoreCount": {
        ...state["restoreCount"],
        player: state["restoreCount"][player] - 1
      }
    };
  }

  bool _checkGame(
    int columnIndex,
    int rowIndex,
    List board,
    String mark,
  ) {
    final gameSettings = ref.read(gameSettingsProvider);
    final int winnerCondition = gameSettings["winnerCondition"];
    final int maxRow = gameSettings["boardSize"] - 1;

    // column
    final columnStart = max(0, columnIndex - winnerCondition + 1);
    final columnEnd = min(maxRow, columnIndex + winnerCondition - 1);

    List<String> columnBoard = [];
    for (int column = columnStart; column <= columnEnd; column++) {
      columnBoard.add(board[column][rowIndex]["mark"]);
    }

    if (_hasWinner(columnBoard, mark, winnerCondition)) return true;

    // row
    final rowStart = max(0, rowIndex - winnerCondition + 1);
    final rowEnd = min(maxRow, rowIndex + winnerCondition - 1);

    List<String> rowBoard = [];
    for (int row = rowStart; row <= rowEnd; row++) {
      rowBoard.add(board[columnIndex][row]["mark"]);
    }

    if (_hasWinner(rowBoard, mark, winnerCondition)) return true;

    // 왼쪽 대각선
    List<String> leftDiagonalBoard = [];
    for (int i = winnerCondition - 1; i > 0; i--) {
      int row = rowIndex - i;
      int column = columnIndex - i;

      if (row >= 0 && column >= 0) {
        leftDiagonalBoard.add(board[column][row]["mark"]);
      }
    }

    for (int i = 0; i < winnerCondition; i++) {
      int row = rowIndex + i;
      int column = columnIndex + i;

      if (row <= rowEnd && column <= columnEnd) {
        leftDiagonalBoard.add(board[column][row]["mark"]);
      }
    }

    if (_hasWinner(leftDiagonalBoard, mark, winnerCondition)) return true;

    // 오른쪽 대각선
    List<String> rightDiagonalBoard = [];
    for (int i = winnerCondition - 1; i > 0; i--) {
      int row = rowIndex + i;
      int column = columnIndex - i;

      if (row <= rowEnd && column >= 0) {
        rightDiagonalBoard.add(board[column][row]["mark"]);
      }
    }

    for (int i = 0; i < winnerCondition; i++) {
      int row = rowIndex - i;
      int column = columnIndex + i;

      if (row >= 0 && column <= columnEnd) {
        rightDiagonalBoard.add(board[column][row]["mark"]);
      }
    }

    if (_hasWinner(rightDiagonalBoard, mark, winnerCondition)) return true;

    return false;
  }

  bool _hasWinner(List unitBoard, String mark, int winnerCondition) {
    for (int i = 0; i <= unitBoard.length - winnerCondition; i++) {
      final isWinner = unitBoard
          .sublist(i, i + winnerCondition)
          .every((item) => item == mark);

      if (isWinner) {
        return true;
      }
    }

    return false;
  }
}
