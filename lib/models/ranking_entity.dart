import 'package:json_annotation/json_annotation.dart';

part 'ranking_entity.g.dart';

@JsonSerializable()
class RankingEntry {
  int rank;
  final String name;
  final int score;
  final int bestTile;
  final bool isCurrentPlayer;

  RankingEntry({
    required this.rank,
    required this.name,
    required this.score,
    required this.bestTile,
    this.isCurrentPlayer = false,
  });

  factory RankingEntry.fromJson(Map<String, dynamic> json) =>
      _$RankingEntryFromJson(json);
  Map<String, dynamic> toJson() => _$RankingEntryToJson(this);
}
