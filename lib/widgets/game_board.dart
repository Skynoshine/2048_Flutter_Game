import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:game/models/direction.dart';
import 'package:game/widgets/game_grid.dart';
import 'package:game/widgets/components/game_overlay.dart';

class GameBoard extends StatelessWidget {
  final GameController controller;

  const GameBoard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.model,
      builder: (context, child) {
        return GestureDetector(
          onPanEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx.abs() >
                details.velocity.pixelsPerSecond.dy.abs()) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                controller.move(Direction.right);
              } else {
                controller.move(Direction.left);
              }
            } else {
              if (details.velocity.pixelsPerSecond.dy > 0) {
                controller.move(Direction.down);
              } else {
                controller.move(Direction.up);
              }
            }
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
            child: Stack(
              children: [
                GameGrid(ct: controller),
                if (controller.model.gameOver)
                  GameOverOverlay(controller: controller),
                if (controller.model.won) WinOverlay(controller: controller),
              ],
            ),
          ),
        );
      },
    );
  }
}
