import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/home/home.dart';
import '../widgets/view_basket_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const tabDefs = [
    ['All', Icons.eco],
    ['Fresh', Icons.local_florist],
    ['Grocery', Icons.shopping_basket],
    ['Snacks', Icons.cookie],
    ['Beverages', Icons.local_cafe],
    ['Beauty', Icons.spa],
  ];

  static const catDefs = [
    ['Fruits & Veggies', Icons.eco, Color(0xFFF3F8EC), 'Fresh'],
    ['Dairy, Eggs & Meat', Icons.egg, Color(0xFFEDF3FC), 'Grocery'],
    ['Bakery & Snacks', Icons.bakery_dining, Color(0xFFFBF2E4), 'Snacks'],
    ['Grocery & Staples', Icons.rice_bowl, Color(0xFFF7F2E5), 'Grocery'],
    ['Beverages', Icons.local_cafe, Color(0xFFFBEEEA), 'Beverages'],
    ['Home & Cleaning', Icons.cleaning_services, Color(0xFFEDF4F8), 'Beauty'],
  ];

  static const colDefs = [
    ['Monsoon essentials', Icons.umbrella, Color(0xFFE7F0FA)],
    ['Pooja essentials', Icons.local_fire_department, Color(0xFFFBE9EC)],
    ['Healthy snacks', Icons.cookie, Color(0xFFF1ECFA)],
    ['Baby care must-haves', Icons.child_care, Color(0xFFEAF6F9)],
    ['Personal care', Icons.spa, Color(0xFFF4EFF8)],
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.select<AppState, CatTheme>((s) => s.theme);
    final accent = context.select<AppState, Color>((s) => s.accent);
    final selectedAddressLine = context.select<AppState, String>((s) => s.selectedAddress.line);
    final currentTab = context.select<AppState, String>((s) => s.tab);
    final app = context.read<AppState>();
    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final navVisible = context.select<AppState, bool>((s) => s.navVisible);
    final cartCount = context.select<AppState, int>((s) => s.cartCount);
    final basketBottom = navVisible
        ? (bottomInset > 0 ? bottomInset + 84 : 96.0)
        : (bottomInset > 0 ? bottomInset + 12 : 16.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      color: theme.solid,
      child: Stack(
        children: [
          BottomNavScrollListener(
            child: CustomScrollView(
              slivers: [
                // 1. Sticky Header with Search, Address and Category Tabs
                SliverPersistentHeader(
                  pinned: true,
                  delegate: HomeHeaderDelegate(
                    theme: theme,
                    accent: accent,
                    selectedAddressLine: selectedAddressLine,
                    currentTab: currentTab,
                    topPadding: topPadding,
                    app: app,
                    tabDefs: tabDefs,
                  ),
                ),

                // 2. Scrollable Home Body Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 104 + bottomInset + (cartCount > 0 ? 68 : 0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),

                        // First Order Perks (Only in 'All' category)
                        if (currentTab == 'All') ...[
                          HomePerksBanner(theme: theme),
                          const SizedBox(height: 14),
                        ],

                        // Main Category Hero Banner
                        HomeCategoryBanner(currentTab: currentTab, app: app),
                        const SizedBox(height: 18),

                        // Section: Shop by Category
                        HomeSectionHeader(
                          title: 'Shop by category',
                          accent: app.accent,
                          onViewAll: () => app.openList('Fruits & Veggies'),
                        ),
                        SizedBox(
                          height: 132,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: catDefs.length,
                            itemBuilder: (_, i) {
                              final d = catDefs[i];
                              final isLast = i == catDefs.length - 1;
                              return GestureDetector(
                                onTap: () => app.goToCategory(d[0] as String, d[3] as String),
                                child: Container(
                                  width: 118,
                                  margin: EdgeInsets.only(right: isLast ? 0 : 10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: d[2] as Color,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Icon(
                                          d[1] as IconData,
                                          size: 40,
                                          color: const Color(0x5512261C),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(16),
                                            ),
                                          ),
                                          child: Text(
                                            d[0] as String,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF12261C),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Section: Twin Promotional Banners
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: HomePromoBanner(
                                  title: 'Fresh veggies\nflat 20% off',
                                  cta: 'Grab now',
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF0E7A4B), Color(0xFF123D2B)],
                                  ),
                                  titleColor: Colors.white,
                                  ctaColor: const Color(0xFFFFE9A8),
                                  onTap: () => app.openList('Fruits & Veggies'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: HomePromoBanner(
                                  title: 'Snacks & sips\nbuy 1 get 1',
                                  cta: 'Explore',
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFF0A93B), Color(0xFFB4762C)],
                                  ),
                                  titleColor: const Color(0xFF12261C),
                                  ctaColor: const Color(0xFF12261C),
                                  onTap: () => app.openList('Bakery & Snacks'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Section: Best Deals for You Card
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                            decoration: BoxDecoration(
                              color: theme.dealsBg,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFEDE8DE),
                                width: 1.2,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Best deals for you',
                                              style: GoogleFonts.playfairDisplay(
                                                fontSize: 19,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(0xFF1E221E),
                                                letterSpacing: -0.3,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            const Text(
                                              'Fresh picks, up to 65% off · ends 9 pm',
                                              style: TextStyle(
                                                fontSize: 12.5,
                                                color: Color(0x8012261C),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      AnimatedDefaultTextStyle(
                                        duration: const Duration(milliseconds: 350),
                                        curve: Curves.easeInOutCubic,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: accent,
                                        ),
                                        child: const Text('View all'),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 13),
                                const HomeProductRow(
                                  productIds: [
                                    'carrot',
                                    'ginger',
                                    'potato',
                                    'tomato',
                                    'spinach',
                                    'capsicum',
                                  ],
                                  imageHeight: 80,
                                  spacing: 10,
                                  horizontalPadding: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Section: Popular this week
                        HomeSectionHeader(
                          title: 'Popular this week',
                          accent: accent,
                          onViewAll: () => app.openList(colDefs.first[0] as String),
                        ),
                        SizedBox(
                          height: 152,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: colDefs.length,
                            itemBuilder: (_, i) {
                              final d = colDefs[i];
                              final isLast = i == colDefs.length - 1;
                              return GestureDetector(
                                onTap: () => app.openList(d[0] as String),
                                child: Container(
                                  width: 132,
                                  margin: EdgeInsets.only(right: isLast ? 0 : 10),
                                  padding: const EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    color: d[2] as Color,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        d[0] as String,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF12261C),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        d[1] as IconData,
                                        size: 34,
                                        color: const Color(0x4712261C),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Section: Bestsellers for you
                        HomeSectionHeader(
                          title: 'Bestsellers for you',
                          accent: accent,
                          onViewAll: () => app.openList('Grocery & Staples'),
                        ),
                        const HomeProductRow(
                          productIds: ['atta', 'oil', 'tea', 'detergent', 'cream', 'rice'],
                          imageHeight: 80,
                          spacing: 10,
                          horizontalPadding: 16,
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating Cart Basket Bar
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
}
