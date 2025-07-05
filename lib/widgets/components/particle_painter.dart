import 'package:flutter/material.dart';

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final particle in particles) {
      final currentX = particle.x + (particle.vx * progress * 100);
      final currentY = particle.y + (particle.vy * progress * 100);
      final currentSize = particle.size * (1 - progress);
      final opacity = (1 - progress) * 0.8;

      paint.color = particle.color.withValues(alpha: opacity);

      canvas.drawCircle(Offset(currentX, currentY), currentSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  double x, y, vx, vy, size;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
  });
}
