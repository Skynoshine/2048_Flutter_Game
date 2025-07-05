import 'package:flutter/material.dart';
import 'package:game/core/utils.dart';

class TileWidget extends StatelessWidget {
  final int value;

  const TileWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Utils.getTileColor(value),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(
            fontSize: Utils.getFontSize(value),
            fontWeight: FontWeight.bold,
            color: Utils.getTextColor(value),
          ),
        ),
      ),
    );
  }

  
}
