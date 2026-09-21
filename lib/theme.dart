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

const _profileTheme = CatTheme(
  solid: Colors.white,
  accent: Color(0xFF0F5A38),
  tint: Color(0xFFE8F6EE),
  dealsBg: Color(0xFFF9F6F0),
  headerGradient: [Color(0xFFE8F6EE), Color(0xFFFFFFFF)],
  perksGradient: [Color(0xFF0F5A38), Color(0xFF168A57)],
);

final Map<String, CatTheme> themes = {
  'All': _profileTheme,
  'Fresh': _profileTheme,
  'Grocery': _profileTheme,
  'Snacks': _profileTheme,
  'Beverages': _profileTheme,
  'Beauty': _profileTheme,
};
