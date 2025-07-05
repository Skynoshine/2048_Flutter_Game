import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game/main.dart';
import 'package:game/models/ranking_entity.dart';
import 'package:game/services/local_cache.dart';
import 'package:logger/logger.dart';
import 'package:unique_names_generator/unique_names_generator.dart';

class RankingController extends ChangeNotifier {
  int rank = 0;
  final List<RankingEntry> rankings = [];
  final LocalCache _cache = di<LocalCache>();

  void init() async {
    await _getUserRanking();
    await _generateRanking();
  }

  Future<void> _getUserRanking() async {
    try {
      rank = await _cache.getUserPreference<int?>(CacheKeys.highScores) ?? 0;
      notifyListeners();
    } catch (e) {
      Logger().e(e, stackTrace: StackTrace.current);
    }
  }

  Future<void> _generateRanking() async {
    try {
      final cached = await _cache.getUserPreference<List<dynamic>>(
        CacheKeys.ranking,
      );

      if (cached != null && cached.isNotEmpty) {
        final loaded = cached
            .map((e) => RankingEntry.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        rankings
          ..clear()
          ..addAll(loaded);
      } else {
        final random = Random();
        final tiles = [32, 64, 128, 256, 512, 1024, 2048];

        String generateNickname() {
          final generator = UniqueNamesGenerator(
            config: Config(
              dictionaries: [adjectives, animals],
              style: Style.capital,
              length: 2,
            ),
          );
          return generator.generate();
        }

        final generated =
            List.generate(10, (index) {
                final isCurrentPlayer = index == 3;

                return RankingEntry(
                  rank: index + 1,
                  name: isCurrentPlayer ? "You" : generateNickname(),
                  score: isCurrentPlayer
                      ? rank
                      : 1000 + random.nextInt(1 << 20),
                  bestTile: tiles[random.nextInt(tiles.length)],
                  isCurrentPlayer: isCurrentPlayer,
                );
              })
              ..sort((a, b) => b.score.compareTo(a.score))
              ..asMap().forEach((i, e) => e.rank = i + 1);

        rankings
          ..clear()
          ..addAll(generated);

        await _cache.setUserPreference(
          CacheKeys.ranking,
          rankings.map((e) => e.toJson()).toList(),
        );
      }

      notifyListeners();
    } catch (e) {
      Logger().e(e, stackTrace: StackTrace.current);
    }
  }
}
