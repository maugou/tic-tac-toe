// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_history_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameResultImpl _$$GameResultImplFromJson(Map<String, dynamic> json) =>
    _$GameResultImpl(
      board: (json['board'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as Map<String, dynamic>).map(
                    (k, e) => MapEntry(k, e as Object),
                  ))
              .toList())
          .toList(),
      winnerPlayer: json['winnerPlayer'] as String,
      boardSize: json['boardSize'] as int,
      winnerCondition: json['winnerCondition'] as int,
    );

Map<String, dynamic> _$$GameResultImplToJson(_$GameResultImpl instance) =>
    <String, dynamic>{
      'board': instance.board,
      'winnerPlayer': instance.winnerPlayer,
      'boardSize': instance.boardSize,
      'winnerCondition': instance.winnerCondition,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameHistoryHash() => r'0050e3f84ca92fc474db5995369b9b02252366ea';

/// See also [GameHistory].
@ProviderFor(GameHistory)
final gameHistoryProvider =
    AsyncNotifierProvider<GameHistory, List<GameResult>>.internal(
  GameHistory.new,
  name: r'gameHistoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gameHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GameHistory = AsyncNotifier<List<GameResult>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
