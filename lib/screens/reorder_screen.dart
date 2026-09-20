import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/product_card.dart';
import '../widgets/view_basket_bar.dart';

class ReorderScreen extends StatelessWidget {
  const ReorderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final navVisible = context.select<AppState, bool>((s) => s.navVisible);
    final cartCount = context.select<AppState, int>((s) => s.cartCount);
    final basketBottom = navVisible
        ? (bottomInset > 0 ? bottomInset + 84 : 96.0)
        : (bottomInset > 0 ? bottomInset + 12 : 16.0);

    // Curated staples for quick addition
    final staples = ['milk', 'bread', 'banana', 'tomato', 'potato', 'carrot', 'spinach']
        .map((id) => byId(id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Page Content
          Positioned.fill(
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 100 + bottomInset + (cartCount > 0 ? 68 : 0)),
              children: [
                // Top Deep Green Curved Header
                _buildHeader(context),

                const SizedBox(height: 20),

                // Empty Orders Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildEmptyOrdersCard(context, app),
                ),

                const SizedBox(height: 28),

                // Frequently Bought / Popular Essentials Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Popular to start with',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E221E),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F6EE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '1-tap reorder',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF0F8A4B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Horizontal Product List
                SizedBox(
                  height: 186,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: staples.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (ctx, i) {
                      return ProductCard(
                        product: staples[i],
                        width: 132,
                        imageHeight: 80,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Order history promise banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF7F2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE8F6EE),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.bolt_rounded, color: Color(0xFF0F8A4B), size: 24),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Express 9-min Reordering',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E221E),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Once delivered, items can be re-added here with the same quantities in a single tap.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF757A75),
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating View Basket Bar
          ViewBasketBar(bottom: basketBottom),

          // Bottom Navigation Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, topPadding + 14, 20, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F5A38), Color(0xFF0A4427)],
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reorder',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.history_rounded, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Quickly re-buy items from your past deliveries',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFBBE5CF),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyOrdersCard(BuildContext context, AppState app) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Graphic Illustration Circle
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 36,
              color: Color(0xFF0F5A38),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'No past orders yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E221E),
            ),
          ),
          const SizedBox(height: 8),

          // Description
          const Text(
            'Items you order will automatically show up here so you can reorder them in just one tap.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF757A75),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 20),

          // CTA button
          ElevatedButton(
            onPressed: () => app.setScreen(Screen.home),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF08482A),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Start Shopping',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
