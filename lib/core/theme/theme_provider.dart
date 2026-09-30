import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeState {
  final ThemeData theme;
  final Color seedColor;
  const ThemeState({required this.theme, required this.seedColor});
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(_initialState());

  static ThemeState _initialState() {
    const hex = String.fromEnvironment('PRIMARY_COLOR', defaultValue: '1A73E8');
    final color = Color(int.parse('FF$hex', radix: 16));
    return ThemeState(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      seedColor: color,
    );
  }

  void applyRemoteConfig({required Color primaryColor}) {
    state = ThemeState(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      seedColor: primaryColor,
    );
  }
}
