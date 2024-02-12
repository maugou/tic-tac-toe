// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_history_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameResult _$GameResultFromJson(Map<String, dynamic> json) {
  return _GameResult.fromJson(json);
}

/// @nodoc
mixin _$GameResult {
  List<List<Map<String, Object>>> get board =>
      throw _privateConstructorUsedError;
  String get winnerPlayer => throw _privateConstructorUsedError;
  int get boardSize => throw _privateConstructorUsedError;
  int get winnerCondition => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameResultCopyWith<GameResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameResultCopyWith<$Res> {
  factory $GameResultCopyWith(
          GameResult value, $Res Function(GameResult) then) =
      _$GameResultCopyWithImpl<$Res, GameResult>;
  @useResult
  $Res call(
      {List<List<Map<String, Object>>> board,
      String winnerPlayer,
      int boardSize,
      int winnerCondition});
}

/// @nodoc
class _$GameResultCopyWithImpl<$Res, $Val extends GameResult>
    implements $GameResultCopyWith<$Res> {
  _$GameResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? winnerPlayer = null,
    Object? boardSize = null,
    Object? winnerCondition = null,
  }) {
    return _then(_value.copyWith(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<Map<String, Object>>>,
      winnerPlayer: null == winnerPlayer
          ? _value.winnerPlayer
          : winnerPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      boardSize: null == boardSize
          ? _value.boardSize
          : boardSize // ignore: cast_nullable_to_non_nullable
              as int,
      winnerCondition: null == winnerCondition
          ? _value.winnerCondition
          : winnerCondition // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameResultImplCopyWith<$Res>
    implements $GameResultCopyWith<$Res> {
  factory _$$GameResultImplCopyWith(
          _$GameResultImpl value, $Res Function(_$GameResultImpl) then) =
      __$$GameResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<Map<String, Object>>> board,
      String winnerPlayer,
      int boardSize,
      int winnerCondition});
}

/// @nodoc
class __$$GameResultImplCopyWithImpl<$Res>
    extends _$GameResultCopyWithImpl<$Res, _$GameResultImpl>
    implements _$$GameResultImplCopyWith<$Res> {
  __$$GameResultImplCopyWithImpl(
      _$GameResultImpl _value, $Res Function(_$GameResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? winnerPlayer = null,
    Object? boardSize = null,
    Object? winnerCondition = null,
  }) {
    return _then(_$GameResultImpl(
      board: null == board
          ? _value._board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<Map<String, Object>>>,
      winnerPlayer: null == winnerPlayer
          ? _value.winnerPlayer
          : winnerPlayer // ignore: cast_nullable_to_non_nullable
              as String,
      boardSize: null == boardSize
          ? _value.boardSize
          : boardSize // ignore: cast_nullable_to_non_nullable
              as int,
      winnerCondition: null == winnerCondition
          ? _value.winnerCondition
          : winnerCondition // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameResultImpl implements _GameResult {
  _$GameResultImpl(
      {required final List<List<Map<String, Object>>> board,
      required this.winnerPlayer,
      required this.boardSize,
      required this.winnerCondition})
      : _board = board;

  factory _$GameResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameResultImplFromJson(json);

  final List<List<Map<String, Object>>> _board;
  @override
  List<List<Map<String, Object>>> get board {
    if (_board is EqualUnmodifiableListView) return _board;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_board);
  }

  @override
  final String winnerPlayer;
  @override
  final int boardSize;
  @override
  final int winnerCondition;

  @override
  String toString() {
    return 'GameResult(board: $board, winnerPlayer: $winnerPlayer, boardSize: $boardSize, winnerCondition: $winnerCondition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameResultImpl &&
            const DeepCollectionEquality().equals(other._board, _board) &&
            (identical(other.winnerPlayer, winnerPlayer) ||
                other.winnerPlayer == winnerPlayer) &&
            (identical(other.boardSize, boardSize) ||
                other.boardSize == boardSize) &&
            (identical(other.winnerCondition, winnerCondition) ||
                other.winnerCondition == winnerCondition));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_board),
      winnerPlayer,
      boardSize,
      winnerCondition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameResultImplCopyWith<_$GameResultImpl> get copyWith =>
      __$$GameResultImplCopyWithImpl<_$GameResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameResultImplToJson(
      this,
    );
  }
}

abstract class _GameResult implements GameResult {
  factory _GameResult(
      {required final List<List<Map<String, Object>>> board,
      required final String winnerPlayer,
      required final int boardSize,
      required final int winnerCondition}) = _$GameResultImpl;

  factory _GameResult.fromJson(Map<String, dynamic> json) =
      _$GameResultImpl.fromJson;

  @override
  List<List<Map<String, Object>>> get board;
  @override
  String get winnerPlayer;
  @override
  int get boardSize;
  @override
  int get winnerCondition;
  @override
  @JsonKey(ignore: true)
  _$$GameResultImplCopyWith<_$GameResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
