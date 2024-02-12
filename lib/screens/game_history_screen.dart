import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/providers/game_history_provider.dart';

class GameHistoryScreen extends ConsumerWidget {
  const GameHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final histories = ref.watch(gameHistoryProvider);

    return switch (histories) {
      AsyncData(:final value) => _ResultList(result: value),
      AsyncError() => const Center(
          child: Text("기록된 게임 로드에 실패하였습니다."),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        )
    };
  }
}

class _ResultList extends StatelessWidget {
  const _ResultList({required this.result});

  final List<GameResult> result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("기록된 게임"),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: result.length,
        separatorBuilder: (context, index) => const Divider(
          thickness: 1,
          height: 40,
          color: Colors.grey,
        ),
        itemBuilder: (context, index) {
          final int size = result[index].boardSize;

          return Container(
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "승리 조건 ${result[index].winnerCondition}",
                  style: const TextStyle(fontSize: 16),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size,
                  ),
                  itemCount: size * size,
                  itemBuilder: (gridContext, gridIndex) {
                    final columnIndex = gridIndex ~/ size;
                    final rowIndex = gridIndex % size;
                    final item = result[index].board[columnIndex][rowIndex];

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          children: [
                            Text(
                              "${item["mark"]}",
                              style: TextStyle(
                                color: Color(
                                  int.parse("${item['colorInt']}"),
                                ),
                              ),
                            ),
                            Text(
                              "${item["order"]}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        result[index].winnerPlayer,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${result[index].winnerPlayer.isNotEmpty ? "(마크 ${result[index].winnerMark}) 승리" : "무승부"} ",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
