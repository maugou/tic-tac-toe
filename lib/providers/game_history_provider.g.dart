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
      winnerMark: json['winnerMark'] as String,
    );

Map<String, dynamic> _$$GameResultImplToJson(_$GameResultImpl instance) =>
    <String, dynamic>{
      'board': instance.board,
      'winnerPlayer': instance.winnerPlayer,
      'boardSize': instance.boardSize,
      'winnerCondition': instance.winnerCondition,
      'winnerMark': instance.winnerMark,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gameHistoryHash() => r'3c29f04947d215ddc4d3aba626471b06a210704c';

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
