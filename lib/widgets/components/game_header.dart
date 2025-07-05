import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:game/widgets/components/score_board.dart';

class GameHeader extends StatelessWidget {
  final GameController controller;

  const GameHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.model,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '2048',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF776E65),
              ),
            ),
            Row(
              children: [
                ScoreBoard(title: 'SCORE', score: controller.model.score),
                SizedBox(width: 10),
                ScoreBoard(title: 'BEST', score: controller.model.bestScore),
              ],
            ),
          ],
        );
      },
    );
  }
}