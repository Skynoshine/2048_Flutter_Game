import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:game/widgets/ranking.dart';

class GameControls extends StatefulWidget {
  final GameController ct;

  const GameControls({super.key, required this.ct});

  @override
  State<GameControls> createState() => _GameControlsState();
}

class _GameControlsState extends State<GameControls> {
  @override
  Widget build(BuildContext context) {
    return !widget.ct.model.gameOver
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => widget.ct.newGame(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8F7A66),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('New Game'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankingScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8F7A66),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Ranking'),
              ),
            ],
          )
        : SizedBox.shrink();
  }
}
