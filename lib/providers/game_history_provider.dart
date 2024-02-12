import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'game_provider.dart';
import 'game_settings_provider.dart';

part "game_history_provider.freezed.dart";
part "game_history_provider.g.dart";

@freezed
class GameResult with _$GameResult {
  factory GameResult({
    required List<List<Map<String, Object>>> board,
    required String winnerPlayer,
    required int boardSize,
    required int winnerCondition,
  }) = _GameResult;

  factory GameResult.fromJson(Map<String, dynamic> json) =>
      _$GameResultFromJson(json);
}

@Riverpod(keepAlive: true)
class GameHistory extends _$GameHistory {
  @override
  Future<List<GameResult>> build() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? history = prefs.getString(SharedPreferencesKeys.history.name);

    if (history == null) {
      return [];
    }

    final histories = jsonDecode(history) as List<dynamic>;

    return histories.map((result) => GameResult.fromJson(result)).toList();
  }

  void recordGameResult(
    void Function() completionHandler,
  ) async {
    state = await AsyncValue.guard(() async {
      final gameSettings = ref.read(gameSettingsProvider);
      final game = ref.read(gameProvider);

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final prevState = await future;

      final result = {
        "board": game["board"],
        "winnerPlayer": game["lastPlayer"],
        "boardSize": gameSettings["boardSize"],
        "winnerCondition": gameSettings["winnerCondition"],
      };

      final currentHistory = [
        GameResult.fromJson(result),
        ...prevState,
      ];

      await prefs.setString(
        SharedPreferencesKeys.history.name,
        jsonEncode(currentHistory),
      );

      completionHandler();
      return currentHistory;
    });
  }
}
