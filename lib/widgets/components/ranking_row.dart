import 'package:flutter/material.dart';
import 'package:game/models/ranking_entity.dart';
import 'package:game/widgets/components/rank_badge.dart';

class RankingRow extends StatelessWidget {
  final RankingEntry entry;
  const RankingRow({required this.entry, super.key});
  @override
  Widget build(BuildContext c) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: entry.isCurrentPlayer
          ? const Color(0xFFEDC53F)
          : const Color(0xFFCDC1B4),
      borderRadius: BorderRadius.circular(4),
      border: entry.isCurrentPlayer
          ? Border.all(color: const Color(0xFFEDC53F), width: 2)
          : null,
    ),
    child: Row(
      children: [
        RankBadge(entry.rank),
        const SizedBox(width: 12),
        Expanded(child: NameScore(entry: entry)),
        TileBadge(tile: entry.bestTile),
      ],
    ),
  );
}