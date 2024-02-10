import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'game_settings_provider.dart';

part 'game_provider.g.dart';

@riverpod
class Game extends _$Game {
  @override
  Map<String, dynamic> build() {
    final gameSettings = ref.read(gameSettingsProvider);

    return {
      "board": List.generate(
        gameSettings["boardSize"],
        (index) => List.generate(
          gameSettings["boardSize"],
          (i) => {
            "mark": "",
            "color": Colors.black,
          },
        ),
      ),
      "isEnd": false,
      "lastPosition": [],
      "restoreCount": {
        "player1": 3,
        "player2": 3,
      }
    };
  }

  void addMark(
      int rowIndex, num columnIndex, String mark, MaterialColor color) {
    List board = state["board"];

    board[rowIndex][columnIndex] = {
      "mark": mark,
      "color": color,
    };

    state = {
      ...state,
      "board": board,
      "lastPosition": [rowIndex, columnIndex]
    };
  }

  void restore(String player) {
    List board = state["board"];
    final indexGroup = state["lastPosition"];

    board[indexGroup[0]][indexGroup[1]] = {
      "mark": "",
      "color": Colors.black,
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
}
