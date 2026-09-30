import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkSpeedIndicator extends StatefulWidget {
  const NetworkSpeedIndicator({super.key});

  @override
  State<NetworkSpeedIndicator> createState() => _NetworkSpeedIndicatorState();
}

class _NetworkSpeedIndicatorState extends State<NetworkSpeedIndicator>
    with SingleTickerProviderStateMixin {
  double _speed = 0;
  StreamSubscription? _sub;
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _check();
    _sub = Connectivity().onConnectivityChanged.listen((_) => _check());
  }

  Future<void> _check() async {
    final r = await Connectivity().checkConnectivity();
    if (!mounted) return;
    setState(() => _speed = r != ConnectivityResult.none ? 125.0 : 0.0);
  }

  @override
  void dispose() {
    _sub?.cancel();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seed = Theme.of(context).colorScheme.primary;
    final isConnected = _speed > 0;

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final glow = 0.5 + 0.5 * math.sin(_pulse.value * 2 * math.pi);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: seed.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: seed.withOpacity(0.6), width: 1),
            boxShadow: [
              BoxShadow(
                color: seed.withValues(alpha: 0.35 * glow),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isConnected ? Icons.bolt : Icons.wifi_off,
                size: 14,
                color: isConnected ? seed : Colors.redAccent,
              ),
              const SizedBox(width: 4),
              Text(
                '${_speed.toStringAsFixed(0)} KB/s',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: seed,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
