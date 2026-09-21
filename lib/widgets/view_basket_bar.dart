import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'basket_sheet.dart';

class ViewBasketBar extends StatelessWidget {
  final double bottom;
  final VoidCallback? onTap;

  const ViewBasketBar({
    super.key,
    this.bottom = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cartCount = context.select<AppState, int>((s) => s.cartCount);
    final cartTotal = context.select<AppState, int>((s) => s.cartTotal);
    final isVisible = cartCount > 0;

    const giftThreshold = 499;
    final awayFromGift = (giftThreshold - cartTotal).clamp(0, giftThreshold);
    final giftProgress = (cartTotal / giftThreshold).clamp(0.04, 1.0);
    final isGiftUnlocked = awayFromGift == 0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
      left: 12,
      right: 12,
      bottom: isVisible ? bottom : -100,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeInOut,
        opacity: isVisible ? 1.0 : 0.0,
        child: IgnorePointer(
          ignoring: !isVisible,
          child: GestureDetector(
            onTap: onTap ?? () => showBasketSheet(context),
            child: Container(
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(34),
                border: Border.all(color: const Color(0xFFEDEAE3), width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 18,
                    offset: Offset(0, 6),
                  ),
                  BoxShadow(
                    color: Color(0x0C063D23),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Left Circular Thumbnail (Apple & Pomegranate)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9F3EA),
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assests/royal_duo.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🍎', style: TextStyle(fontSize: 18)),
                            SizedBox(width: 2),
                            Text('🫐', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Middle Section: Title, Subtitle, Progress bar
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Get Free Royal Duo',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF141F17),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 12.5,
                            ),
                            children: isGiftUnlocked
                                ? const [
                                    TextSpan(
                                      text: 'Free gift unlocked!',
                                      style: TextStyle(
                                        color: Color(0xFF0F8A4B),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ]
                                : [
                                    TextSpan(
                                      text: '₹$awayFromGift',
                                      style: const TextStyle(
                                        color: Color(0xFF0F8A4B),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' away to unlock gift',
                                      style: TextStyle(
                                        color: Color(0xFF637167),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: giftProgress,
                            minHeight: 3.5,
                            backgroundColor: const Color(0xFFE2EBE5),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF08482A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Right Section: Pill Cart Button
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 18, right: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF063D23),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Cart',
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEEF6EE),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$cartCount',
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF063D23),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
