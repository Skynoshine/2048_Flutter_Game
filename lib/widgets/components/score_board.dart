import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final String title;
  final int score;

  const ScoreBoard({super.key, required this.title, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFBBADA0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEEE4DA),
            ),
          ),
          Text(
            score.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}