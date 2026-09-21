import 'package:flutter/material.dart';
import '../../theme.dart';

class HomePerksBanner extends StatelessWidget {
  final CatTheme theme;

  const HomePerksBanner({
    super.key,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.fromLTRB(12, 13, 12, 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: theme.perksGradient),
          boxShadow: const [
            BoxShadow(
            color: Color(0x1A000000),
              blurRadius: 18,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: const Column(
          children: [
            Text(
              'Your first order comes with perks',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _PerkItem(big: '₹50', small: 'OFF', text: 'on orders over ₹299'),
                _PerkItem(big: '₹150', small: 'OFF', text: 'on orders over ₹399'),
                _PerkItem(big: 'FREE', small: 'DELIV', text: 'on first 4 orders'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PerkItem extends StatelessWidget {
  final String big;
  final String small;
  final String text;

  const _PerkItem({
    required this.big,
    required this.small,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: const BoxDecoration(
              color: Color(0xFFFFE9A8),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  big,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF12261C),
                    height: 1.1,
                  ),
                ),
                Text(
                  small,
                  style: const TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w600,
                    color: Color(0x9912261C),
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
