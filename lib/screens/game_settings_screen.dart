import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';
import '../providers/game_settings_provider.dart';

class GameSettingsScreen extends ConsumerStatefulWidget {
  const GameSettingsScreen({super.key});

  @override
  ConsumerState<GameSettingsScreen> createState() => _GameSettingsScreenState();
}

class _GameSettingsScreenState extends ConsumerState<GameSettingsScreen> {
  final TextEditingController _boardSizeController = TextEditingController();
  final TextEditingController _winnerConditionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static const int minimumSize = 3;

  @override
  Widget build(BuildContext context) {
    final defaultGameSettings = ref.watch(gameSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('게임 설정'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _boardSizeController,
                    decoration: const InputDecoration(
                        labelText: '게임판의 크기 (가로 칸 수)',
                        hintText: "가로 길이 입력해주세요 (최소 3이상)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) < minimumSize) {
                        return "3 이상의 숫자를 입력하세요.";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _winnerConditionController,
                    decoration: const InputDecoration(
                        labelText: '승리 조건',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (_boardSizeController.text.isEmpty ||
                          int.parse(_boardSizeController.text) < minimumSize) {
                        return null;
                      }

                      if (value == null || value.isEmpty) {
                        return "승리 조건은 필수 값입니다";
                      }

                      final winnerCondition = int.parse(value);
                      final boardSize = int.parse(_boardSizeController.text);

                      if (boardSize == minimumSize &&
                          winnerCondition != minimumSize) {
                        return '승리 조건은 3이어야 합니다';
                      }

                      if (winnerCondition < minimumSize ||
                          winnerCondition > boardSize) {
                        return "3 이상 $boardSize 이하의 숫자를 입력하세요";
                      }

                      return null;
                    },
                  ),
                  const Divider(
                    height: 40,
                  ),
                  const _PlayerSettings(player: "player1"),
                  const SizedBox(
                    height: 20,
                  ),
                  const _PlayerSettings(player: "player2"),
                  const Divider(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "먼저 진행할 player",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            ref
                                .read(gameSettingsProvider.notifier)
                                .togglePlayer(
                                    defaultGameSettings["currentPlayer"]);
                          },
                          child: Text(
                            "${defaultGameSettings["currentPlayer"]}",
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(gameSettingsProvider.notifier).setGame(
                              size: _boardSizeController.text,
                              winnerCondition: _winnerConditionController.text,
                            );

                        context.go('/game_ground');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.only(
                        left: 60,
                        right: 60,
                        top: 20,
                        bottom: 20,
                      ),
                    ),
                    child: const Text(
                      'Game 시작',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayerSettings extends ConsumerWidget {
  const _PlayerSettings({
    required this.player,
  });

  final String player;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultGameSettings = ref.watch(gameSettingsProvider);
    final otherPlayer = player == "player1" ? "player2" : "player1";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          player,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    actions: <CupertinoActionSheetAction>[
                      ...mark.map((playerMark) {
                        return CupertinoActionSheetAction(
                          onPressed: () {
                            if (playerMark.mark ==
                                defaultGameSettings[otherPlayer]["mark"]) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: const Text("다른 Player와 동일한 마크입니다"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text("확인"),
                                    )
                                  ],
                                ),
                              );

                              return;
                            } else {
                              ref.read(gameSettingsProvider.notifier).setPlayer(
                                  player: player, mark: playerMark.mark);

                              Navigator.pop(context);
                            }
                          },
                          child: Text(playerMark.koreanName),
                        );
                      })
                    ],
                  ),
                );
              },
              child: Text(
                "마크 ${defaultGameSettings[player]["mark"]}",
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: defaultGameSettings[player]["color"],
                ),
              ),
              onPressed: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    actions: <CupertinoActionSheetAction>[
                      ...playerColor.map((color) {
                        return CupertinoActionSheetAction(
                          onPressed: () {
                            if (color ==
                                defaultGameSettings[otherPlayer]["color"]) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  content: const Text("다른 Player와 동일한 색상입니다"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text("확인"),
                                    )
                                  ],
                                ),
                              );

                              return;
                            } else {
                              ref
                                  .read(gameSettingsProvider.notifier)
                                  .setPlayer(player: player, color: color);
                            }

                            Navigator.pop(context);
                          },
                          child: Text(
                            "${defaultGameSettings[player]["mark"]}",
                            style: TextStyle(color: color),
                          ),
                        );
                      })
                    ],
                  ),
                );
              },
              child: Text(
                "색상",
                style: TextStyle(color: defaultGameSettings[player]["color"]),
              ),
            ),
          ],
        )
      ],
    );
  }
}
