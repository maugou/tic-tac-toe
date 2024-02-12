import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/providers/game_provider.dart';

import '../providers/game_settings_provider.dart';

class GameGroundScreen extends ConsumerWidget {
  const GameGroundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final game = ref.watch(gameProvider);

    final int boardSize = gameSettings["boardSize"];
    final board = game["board"];
    final player = gameSettings["currentPlayer"];

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  context.go('/');
                },
                icon: const Icon(Icons.clear),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: boardSize,
                  ),
                  itemCount: boardSize * boardSize,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final columnIndex = index ~/ boardSize;
                    final rowIndex = index % boardSize;
                    final item = board[columnIndex][rowIndex];

                    return GestureDetector(
                      onTap: () {
                        if (item["mark"].isEmpty) {
                          ref.read(gameProvider.notifier).addMark(
                                columnIndex,
                                rowIndex,
                                gameSettings[player]["mark"],
                                gameSettings[player]["color"],
                                player,
                              );
                          ref
                              .read(gameSettingsProvider.notifier)
                              .togglePlayer(player);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            item["mark"],
                            style: TextStyle(color: item['color']),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text("승리조건 : ${gameSettings["winnerCondition"]}"),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PlayerStatus(player: "player1"),
                    _PlayerStatus(player: "player2")
                  ],
                ),
              ],
            ),
          ),
        ),
        if (game["isEnd"])
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Dialog(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      game["lastPlayer"].isNotEmpty ? 'Winner' : "무승부",
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Text("${game["lastPlayer"]}"),
                    const SizedBox(height: 30),
                    const Text("게임 결과를 저장하시겠습니까 ?"),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: const Text(
                            '아니오',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: const Text(
                            '예',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PlayerStatus extends ConsumerWidget {
  const _PlayerStatus({
    required this.player,
  });

  final String player;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSettings = ref.watch(gameSettingsProvider);
    final game = ref.watch(gameProvider);

    final currentPlayer = gameSettings["currentPlayer"];
    final restorePossibleCount = game["restoreCount"][player];

    return Container(
      decoration: BoxDecoration(
        color: player == currentPlayer
            ? Colors.orange.shade300
            : Colors.transparent,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            player,
          ),
          Text(
            gameSettings[player]["mark"],
            style: TextStyle(
              fontSize: 26,
              color: gameSettings[player]["color"],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "남은 되돌리기 횟수",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            "$restorePossibleCount",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          if (game["lastPosition"].isNotEmpty &&
              player != currentPlayer &&
              restorePossibleCount > 0)
            OutlinedButton(
              onPressed: () {
                ref.read(gameProvider.notifier).restore(player);
                ref
                    .read(gameSettingsProvider.notifier)
                    .togglePlayer(currentPlayer);
              },
              child: const Text(
                "되돌리기",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
        ],
      ),
    );
  }
}
