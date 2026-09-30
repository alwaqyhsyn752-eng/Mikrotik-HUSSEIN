import 'dart:math' as math;
import 'package:flutter/material.dart';

/// خلفية مستقبلية متحركة بأشعة نيون
class AuroraBackground extends StatefulWidget {
  final Widget child;
  const AuroraBackground({super.key, required this.child});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(color: Color(0xFF06070D)),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (context, _) {
              final t = _ctrl.value * 2 * math.pi;
              return CustomPaint(
                painter: _AuroraPainter(seed: seed, phase: t),
              );
            },
          ),
        ),
        Positioned.fill(child: widget.child),
      ],
    );
  }
}

class _AuroraPainter extends CustomPainter {
  final Color seed;
  final double phase;

  _AuroraPainter({required this.seed, required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    final blobs = [
      _Blob(
        color: seed.withOpacity(0.35),
        radius: size.width * 0.55,
        center: Offset(
          size.width * (0.25 + 0.15 * math.sin(phase)),
          size.height * (0.20 + 0.10 * math.cos(phase * 1.3)),
        ),
      ),
      _Blob(
        color: seed.withOpacity(0.22),
        radius: size.width * 0.65,
        center: Offset(
          size.width * (0.80 + 0.12 * math.cos(phase * 1.1)),
          size.height * (0.70 + 0.15 * math.sin(phase * 0.9)),
        ),
      ),
      _Blob(
        color: const Color(0xFF7C4DFF).withOpacity(0.22),
        radius: size.width * 0.5,
        center: Offset(
          size.width * (0.50 + 0.20 * math.cos(phase * 0.7)),
          size.height * (0.45 + 0.20 * math.sin(phase * 1.4)),
        ),
      ),
    ];

    for (final b in blobs) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            b.color,
            b.color.withOpacity(0),
          ],
        ).createShader(Rect.fromCircle(center: b.center, radius: b.radius))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
      canvas.drawCircle(b.center, b.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_AuroraPainter old) => old.phase != phase;
}

class _Blob {
  final Color color;
  final double radius;
  final Offset center;
  const _Blob({
    required this.color,
    required this.radius,
    required this.center,
  });
}
