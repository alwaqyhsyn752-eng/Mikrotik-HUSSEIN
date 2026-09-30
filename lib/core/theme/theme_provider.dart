import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeState {
  final ThemeData theme;
  final Color seed;
  final List<Color> gradient;
  const ThemeState({
    required this.theme,
    required this.seed,
    required this.gradient,
  });
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(_build());

  static ThemeState _build() {
    const hex = String.fromEnvironment('PRIMARY_COLOR', defaultValue: '00E5FF');
    final seed = Color(int.parse('FF$hex', radix: 16));
    return ThemeState(
      theme: _themeFrom(seed),
      seed: seed,
      gradient: _gradientFrom(seed),
    );
  }

  static ThemeData _themeFrom(Color seed) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFF06070D),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.04),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: seed.withOpacity(0.25),
            width: 1,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF0B0E18).withOpacity(0.9),
        indicatorColor: seed.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF080A12),
      ),
    );
  }

  static List<Color> _gradientFrom(Color seed) {
    return [
      const Color(0xFF06070D),
      seed.withOpacity(0.12),
      const Color(0xFF06070D),
      seed.withOpacity(0.08),
    ];
  }

  void applyRemoteConfig({required Color primaryColor}) {
    state = ThemeState(
      theme: _themeFrom(primaryColor),
      seed: primaryColor,
      gradient: _gradientFrom(primaryColor),
    );
  }
}
