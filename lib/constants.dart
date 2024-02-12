import 'package:flutter/material.dart';

enum PlayerMark {
  circle('○', '동그라미'),
  square('□', '네모'),
  triangle('△', '세모'),
  xMark('✕', '엑스');

  const PlayerMark(this.mark, this.koreanName);
  final String mark;
  final String koreanName;
}

const playerColor = [Colors.red, Colors.blue, Colors.green, Colors.purple];
const mark = [
  PlayerMark.circle,
  PlayerMark.square,
  PlayerMark.triangle,
  PlayerMark.xMark
];

const playerGroup = ["player1", "player2"];

enum SharedPreferencesKeys {
  history,
}
