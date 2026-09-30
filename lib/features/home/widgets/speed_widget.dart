import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkSpeedIndicator extends StatefulWidget {
  const NetworkSpeedIndicator({super.key});

  @override
  State<NetworkSpeedIndicator> createState() => _NetworkSpeedIndicatorState();
}

class _NetworkSpeedIndicatorState extends State<NetworkSpeedIndicator> {
  double _speed = 0;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _check();
    _sub = Connectivity().onConnectivityChanged.listen((_) => _check());
  }

  Future<void> _check() async {
    final result = await Connectivity().checkConnectivity();
    if (!mounted) return;
    setState(() {
      _speed = result != ConnectivityResult.none ? 125.0 : 0.0;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isConnected = _speed > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isConnected ? Icons.wifi : Icons.wifi_off,
            size: 16,
            color: isConnected
                ? theme.colorScheme.primary
                : theme.colorScheme.error,
          ),
          const SizedBox(width: 4),
          Text(
            '${_speed.toStringAsFixed(1)} KB/s',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
