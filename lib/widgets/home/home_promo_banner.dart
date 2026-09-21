import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePromoBanner extends StatelessWidget {
  final String title;
  final String cta;
  final Gradient gradient;
  final Color titleColor;
  final Color ctaColor;
  final VoidCallback? onTap;

  const HomePromoBanner({
    super.key,
    required this.title,
    required this.cta,
    required this.gradient,
    required this.titleColor,
    required this.ctaColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 98,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: titleColor,
                height: 1.15,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  cta,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: ctaColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 11, color: ctaColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
