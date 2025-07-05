import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';

class GameOverOverlay extends StatelessWidget {
  final GameController controller;

  const GameOverOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF776E65),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.newGame(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8F7A66),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class WinOverlay extends StatelessWidget {
  final GameController controller;

  const WinOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You Win!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF776E65),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => controller.newGame(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8F7A66),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('New Game'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.model.won = false;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8F7A66),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text('Continue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
