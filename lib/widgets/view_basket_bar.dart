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
    final cartSaved = context.select<AppState, int>((s) => s.cartSaved);
    final isVisible = cartCount > 0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
      left: 12,
      right: 12,
      bottom: isVisible ? bottom : -90,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeInOut,
        opacity: isVisible ? 1.0 : 0.0,
        child: IgnorePointer(
          ignoring: !isVisible,
          child: GestureDetector(
            onTap: onTap ?? () => showBasketSheet(context),
            child: Container(
              height: 58,
              padding: const EdgeInsets.fromLTRB(14, 0, 8, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A5C39), Color(0xFF12A05F)],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x570A5C39),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$cartCount items · ₹$cartTotal',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'You saved ₹$cartSaved on this basket',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xBFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View basket',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0A5C39),
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 13,
                          color: Color(0xFF0A5C39),
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
