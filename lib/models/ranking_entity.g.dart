// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingEntry _$RankingEntryFromJson(Map<String, dynamic> json) => RankingEntry(
  rank: (json['rank'] as num).toInt(),
  name: json['name'] as String,
  score: (json['score'] as num).toInt(),
  bestTile: (json['bestTile'] as num).toInt(),
  isCurrentPlayer: json['isCurrentPlayer'] as bool? ?? false,
);

Map<String, dynamic> _$RankingEntryToJson(RankingEntry instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'name': instance.name,
      'score': instance.score,
      'bestTile': instance.bestTile,
      'isCurrentPlayer': instance.isCurrentPlayer,
    };
