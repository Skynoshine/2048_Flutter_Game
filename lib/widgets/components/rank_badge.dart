import 'package:flutter/material.dart';
import 'package:game/core/utils.dart';
import 'package:game/models/ranking_entity.dart';

class RankBadge extends StatelessWidget {
  final int rank;
  const RankBadge(this.rank, {super.key});
  Color _getColor() {
    return switch (rank) {
      1 => const Color(0xFFFFD700),
      2 => const Color(0xFFC0C0C0),
      3 => const Color(0xFFCD7F32),
      _ => const Color(0xFF8F7A66),
    };
  }

  @override
  Widget build(BuildContext c) => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: _getColor(),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(
        '#$rank',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ),
  );
}

class NameScore extends StatelessWidget {
  final RankingEntry entry;
  const NameScore({required this.entry, super.key});
  @override
  Widget build(BuildContext c) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        entry.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF776E65),
        ),
      ),
      Text(
        'Score: ${entry.score.toString().replaceAllMapped(RegExp(r'(\\d)(?=(\\d{3})+\$)'), (m) => '${m[1]},')}',
        style: TextStyle(
          fontSize: 12,
          color: const Color(0xFF776E65).withValues(alpha: 0.7),
        ),
      ),
    ],
  );
}

class TileBadge extends StatelessWidget {
  final int tile;
  const TileBadge({required this.tile, super.key});
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Utils.getTileColor(tile),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      tile.toString(),
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: tile <= 4 ? const Color(0xFF776E65) : Colors.white,
      ),
    ),
  );
}
