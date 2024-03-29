import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/constants.dart';

part 'game_settings_provider.g.dart';

@riverpod
class GameSettings extends _$GameSettings {
  @override
  Map<String, dynamic> build() {
    return {
      "boardSize": 0,
      "winnerCondition": 0,
      "currentPlayer": playerGroup[Random().nextInt(2)],
      "player1": {
        "mark": PlayerMark.xMark.mark,
        "color": Colors.blue,
      },
      "player2": {
        "mark": PlayerMark.circle.mark,
        "color": Colors.red,
      },
    };
  }

  void setGame({
    required String size,
    required String winnerCondition,
  }) {
    final length = int.parse(size);
    final winnerLength = int.parse(winnerCondition);

    state = {
      ...state,
      "boardSize": length,
      "winnerCondition": winnerLength,
    };
  }

  void setPlayer({
    required String player,
    String? mark,
    MaterialColor? color,
  }) {
    final playerInfo = {
      "mark": mark ?? state[player]["mark"],
      "color": color ?? state[player]["color"],
    };

    state = {
      ...state,
      player: playerInfo,
    };
  }

  void togglePlayer(player) {
    state = {
      ...state,
      "currentPlayer": player == 'player1' ? "player2" : "player1",
    };
  }
}
