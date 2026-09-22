import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final Color accent;
  final VoidCallback? onViewAll;

  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.accent,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E221E),
                letterSpacing: -0.3,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
                child: const Text('View all'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
