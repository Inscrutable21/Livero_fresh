import 'package:flutter/material.dart';

class CatTheme {
  final Color solid, accent, tint, dealsBg;
  final List<Color> headerGradient, perksGradient;
  const CatTheme({
    required this.solid,
    required this.accent,
    required this.tint,
    required this.dealsBg,
    required this.headerGradient,
    required this.perksGradient,
  });
}

final Map<String, CatTheme> themes = {
  'All': const CatTheme(
    solid: Color(0xFFEDF8F1), accent: Color(0xFF0E7A4B), tint: Color(0xFFDCF0E4), dealsBg: Color(0xFFEFF8F1),
    headerGradient: [Color(0xFFDCF2E4), Color(0xFFF1FAF4)], perksGradient: [Color(0xFF0E7A4B), Color(0xFF7FD3A2)],
  ),
  'Fresh': const CatTheme(
    solid: Color(0xFFFDF6E2), accent: Color(0xFF8A6209), tint: Color(0xFFFBEFC8), dealsBg: Color(0xFFFFF6E2),
    headerGradient: [Color(0xFFFBEFC9), Color(0xFFFEFBEF)], perksGradient: [Color(0xFF8A6209), Color(0xFFF0CE72)],
  ),
  'Grocery': const CatTheme(
    solid: Color(0xFFFDECF3), accent: Color(0xFFB3306B), tint: Color(0xFFF9DDE9), dealsBg: Color(0xFFFDECF3),
    headerGradient: [Color(0xFFFBE0EC), Color(0xFFFEF5F8)], perksGradient: [Color(0xFFB3306B), Color(0xFFEFA3C2)],
  ),
  'Snacks': const CatTheme(
    solid: Color(0xFFEAF1FC), accent: Color(0xFF2A5AAE), tint: Color(0xFFD9E6F9), dealsBg: Color(0xFFEAF1FC),
    headerGradient: [Color(0xFFDDE8FA), Color(0xFFF4F8FE)], perksGradient: [Color(0xFF2A5AAE), Color(0xFFA6C4EE)],
  ),
  'Beverages': const CatTheme(
    solid: Color(0xFFFCEDE7), accent: Color(0xFFB4442A), tint: Color(0xFFFADFD5), dealsBg: Color(0xFFFCEDE7),
    headerGradient: [Color(0xFFFBE2D8), Color(0xFFFEF6F3)], perksGradient: [Color(0xFFB4442A), Color(0xFFF0B49C)],
  ),
  'Beauty': const CatTheme(
    solid: Color(0xFFF2EBFB), accent: Color(0xFF6B3FA0), tint: Color(0xFFE7DCF6), dealsBg: Color(0xFFF2EBFB),
    headerGradient: [Color(0xFFE9DEF7), Color(0xFFF8F5FD)], perksGradient: [Color(0xFF6B3FA0), Color(0xFFC6ABE4)],
  ),
};
