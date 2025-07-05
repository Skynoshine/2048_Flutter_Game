import 'package:flutter/material.dart';
import 'package:game/controllers/ranking_controller.dart';
import 'package:game/main.dart';
import 'package:game/widgets/components/ranking_row.dart';
import 'package:game/widgets/components/statcard.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  late final RankingController ct;

  @override
  void initState() {
    super.initState();
    ct = di<RankingController>();
    ct.addListener(_onControllerUpdate);
    ct.init();
  }

  @override
  void dispose() {
    ct.removeListener(_onControllerUpdate);
    super.dispose();
  }

  void _onControllerUpdate() => setState(() {});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFFAF8EF),
    appBar: AppBar(
      backgroundColor: const Color(0xFFFAF8EF),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF776E65)),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Ranking',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF776E65),
        ),
      ),
    ),
    body: Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFBBADA0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              StatCard('Global', '1,321,234'),
              StatCard('Today', '678'),
              StatCard('This Week', '19,456'),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFBBADA0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: ct.rankings.length,
              itemBuilder: (c, i) => RankingRow(entry: ct.rankings[i]),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8F7A66),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Back to Game',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Ranking updated every 7 days.',
            style: TextStyle(fontSize: 12, color: Color(0xFF776E65)),
          ),
        ),
      ],
    ),
  );
}
