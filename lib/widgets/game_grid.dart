import 'package:flutter/material.dart';
import 'package:game/controllers/game_controller.dart';
import 'package:game/widgets/components/animated_tile.dart';
import 'package:game/widgets/components/particle_painter.dart';
import 'dart:math' as math;

class GameGrid extends StatefulWidget {
  final GameController ct;

  const GameGrid({super.key, required this.ct});

  @override
  State<GameGrid> createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> with TickerProviderStateMixin {
  GameController get ct => widget.ct;
  late AnimationController _moveController;
  late AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    widget.ct.addListener(_onGameStateChanged);
  }

  @override
  void dispose() {
    _moveController.dispose();
    _particleController.dispose();
    widget.ct.removeListener(_onGameStateChanged);
    super.dispose();
  }

  void _onGameStateChanged() {
    final now = DateTime.now();

    if (ct.lastMoveTime != null) {
      final timeDiff = now.difference(ct.lastMoveTime!).inMilliseconds;
      ct.isMovingFast = timeDiff < 200;

      if (ct.isMovingFast) {
        _generateParticles();
      }
    }

    ct.lastMoveTime = now;
    _moveController.forward().then((_) {
      _moveController.reset();
    });
  }

  void _generateParticles() {
    ct.particles.clear();
    for (int i = 0; i < 15; i++) {
      ct.particles.add(
        Particle(
          x: math.Random().nextDouble() * 300,
          y: math.Random().nextDouble() * 300,
          vx: (math.Random().nextDouble() - 0.5) * 4,
          vy: (math.Random().nextDouble() - 0.5) * 4,
          color: Color.fromRGBO(
            200 + math.Random().nextInt(56),
            150 + math.Random().nextInt(56),
            100 + math.Random().nextInt(56),
            0.8,
          ),
          size: 2 + math.Random().nextDouble() * 4,
        ),
      );
    }
    _particleController.forward().then((_) {
      _particleController.reset();
      ct.particles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFBBADA0),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: 16,
            itemBuilder: (context, index) {
              int row = index ~/ 4;
              int col = index % 4;
              return AnimatedTile(
                value: widget.ct.model.grid[row][col],
                animationController: _moveController,
                delay: index * 0.01,
              );
            },
          ),
          if (ct.isMovingFast && ct.particles.isNotEmpty)
            AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(
                    ct.particles,
                    _particleController.value,
                  ),
                  size: Size(300, 300),
                );
              },
            ),
        ],
      ),
    );
  }
}

