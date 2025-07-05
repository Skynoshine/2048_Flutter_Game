import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title, value;
  const StatCard(this.title, this.value, {super.key});
  @override
  Widget build(BuildContext c) => Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF776E65),
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF776E65),
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}