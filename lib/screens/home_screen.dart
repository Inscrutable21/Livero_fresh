import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/location_sheet.dart';
import '../widgets/view_basket_bar.dart';

class _CategoryBannerData {
  final String title;
  final String subtitle;
  final String badge;
  final String buttonText;
  final String targetCategory;
  final LinearGradient gradient;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color badgeBg;
  final Color badgeTextColor;
  final IconData icon;

  const _CategoryBannerData({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.buttonText,
    required this.targetCategory,
    required this.gradient,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.badgeBg,
    required this.badgeTextColor,
    required this.icon,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const tabDefs = [['All', Icons.eco], ['Fresh', Icons.local_florist], ['Grocery', Icons.shopping_basket], ['Snacks', Icons.cookie], ['Beverages', Icons.local_cafe], ['Beauty', Icons.spa]];
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

  static const Map<String, _CategoryBannerData> _categoryBanners = {
    'All': _CategoryBannerData(
      title: 'FESTIVAL\nMITTHAAS KA',
      subtitle: 'Starting @ ₹99 · Sweets, gifts & more',
      badge: 'FESTIVE SPECIAL',
      buttonText: 'Shop now',
      targetCategory: 'Festival mitthaas',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFCFE4F7), Color(0xFFF3F1E4)],
      ),
      textColor: Color(0xFF12261C),
      buttonColor: Color(0xFF12261C),
      buttonTextColor: Colors.white,
      badgeBg: Color(0x2812261C),
      badgeTextColor: Color(0xFF12261C),
      icon: Icons.celebration_rounded,
    ),
    'Fresh': _CategoryBannerData(
      title: 'FARM FRESH\nVEGGIES & FRUITS',
      subtitle: 'Flat 20% OFF · Harvested daily',
      badge: '100% FRESH',
      buttonText: 'Explore fresh',
      targetCategory: 'Fruits & Veggies',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFD3EED8), Color(0xFFFBF8D7)],
      ),
      textColor: Color(0xFF0D4B2A),
      buttonColor: Color(0xFF0D4B2A),
      buttonTextColor: Colors.white,
      badgeBg: Color(0x280D4B2A),
      badgeTextColor: Color(0xFF0D4B2A),
      icon: Icons.eco_rounded,
    ),
    'Grocery': _CategoryBannerData(
      title: 'DAILY STAPLES\n& PANTRY MUSTS',
      subtitle: 'Min 25% OFF · Atta, Dals & Oils',
      badge: 'SUPER SAVER',
      buttonText: 'Stock up',
      targetCategory: 'Grocery & Staples',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFCE1EC), Color(0xFFFBF2E3)],
      ),
      textColor: Color(0xFF821A4B),
      buttonColor: Color(0xFF821A4B),
      buttonTextColor: Colors.white,
      badgeBg: Color(0x28821A4B),
      badgeTextColor: Color(0xFF821A4B),
      icon: Icons.shopping_basket_rounded,
    ),
    'Snacks': _CategoryBannerData(
      title: 'CRUNCH TIME\nSNACKS & BITES',
      subtitle: 'Buy 1 Get 1 Free · Chips & Munchies',
      badge: 'CRAVINGS CORNER',
      buttonText: 'Grab bites',
      targetCategory: 'Bakery & Snacks',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFD6E7FE), Color(0xFFFDF0DA)],
      ),
      textColor: Color(0xFF1B4280),
      buttonColor: Color(0xFF1B4280),
      buttonTextColor: Colors.white,
      badgeBg: Color(0x281B4280),
      badgeTextColor: Color(0xFF1B4280),
      icon: Icons.cookie_rounded,
    ),
    'Beverages': _CategoryBannerData(
      title: 'CHILLED DRINKS\n& FRESH BREWS',
      subtitle: 'Flat 30% OFF · Teas, Coffees & Sodas',
      badge: 'REFRESH & CHILL',
      buttonText: 'Order sips',
      targetCategory: 'Beverages',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFBDFD3), Color(0xFFFDF5DE)],
      ),
      textColor: Color(0xFF8D3219),
      buttonColor: Color(0xFF8D3219),
      buttonTextColor: Colors.white,
      badgeBg: Color(0x288D3219),
      badgeTextColor: Color(0xFF8D3219),
      icon: Icons.local_cafe_rounded,
    ),
    'Beauty': _CategoryBannerData(
      title: 'GLOW ROUTINE\nSKIN & SELF CARE',
      subtitle: 'Up to 50% OFF · Wellness & Hygiene',
      badge: 'SELF-CARE PICKS',
      buttonText: 'Discover glow',
      targetCategory: 'Personal care',
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEADBFA), Color(0xFFFDE9F4)],
      ),
      textColor: Color(0xFF552588),
      buttonColor: Color(0xFF552588),
      buttonTextColor: Colors.white,
      badgeBg: Color(0x28552588),
      badgeTextColor: Color(0xFF552588),
      icon: Icons.spa_rounded,
    ),
  };

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
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _HomeHeaderDelegate(
                    theme: theme,
                    accent: accent,
                    selectedAddressLine: selectedAddressLine,
                    currentTab: currentTab,
                    topPadding: topPadding,
                    app: app,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 104 + bottomInset + (cartCount > 0 ? 68 : 0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
            padding: const EdgeInsets.fromLTRB(12, 13, 12, 14),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: theme.perksGradient), boxShadow: const [BoxShadow(color: Color(0x28122612), blurRadius: 18, offset: Offset(0, 6))]),
            child: Column(children: [
              const Text('Your first order comes with perks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.5)),
              const SizedBox(height: 12),
              Row(children: [
                _perk('₹50', 'OFF', 'on orders over ₹299'),
                _perk('₹150', 'OFF', 'on orders over ₹399'),
                _perk('FREE', 'DELIV', 'on first 4 orders'),
              ]),
            ]),
          )),
          const SizedBox(height: 14),
          _categoryBanner(context, app, currentTab),
          const SizedBox(height: 18),
          _sectionHeader('Shop by category', app.accent),
          SizedBox(height: 132, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: catDefs.length, itemBuilder: (_, i) {
            final d = catDefs[i];
            final isLast = i == catDefs.length - 1;
            return GestureDetector(
              onTap: () => app.goToCategory(d[0] as String, d[3] as String),
              child: Container(
                width: 118,
                margin: EdgeInsets.only(right: isLast ? 0 : 10),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: d[2] as Color, borderRadius: BorderRadius.circular(16)),
                child: Stack(children: [
                  Center(child: Icon(d[1] as IconData, size: 40, color: const Color(0x5512261C))),
                  Positioned(
                    left: 0, right: 0, bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                      child: Text(
                        d[0] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF12261C)),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          })),
          const SizedBox(height: 16),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [
            Expanded(child: _promoBanner('Fresh veggies\nflat 20% off', 'Grab now', const LinearGradient(colors: [Color(0xFF0E7A4B), Color(0xFF123D2B)]), Colors.white, const Color(0xFFFFE9A8))),
            const SizedBox(width: 10),
            Expanded(child: _promoBanner('Snacks & sips\nbuy 1 get 1', 'Explore', const LinearGradient(colors: [Color(0xFFF0A93B), Color(0xFFB4762C)]), const Color(0xFF12261C), const Color(0xFF12261C))),
          ])),
          const SizedBox(height: 18),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(color: theme.dealsBg, borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 14), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Best deals for you', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                  SizedBox(height: 3),
                  Text('Fresh picks, up to 65% off · ends 9 pm', style: TextStyle(fontSize: 10.5, color: Color(0x8012261C))),
                ])),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: accent),
                  child: const Text('View all'),
                ),
              ])),
              const SizedBox(height: 13),
              const _ProductRow(
                productIds: ['carrot', 'ginger', 'potato', 'tomato', 'spinach', 'capsicum'],
                imageHeight: 80,
                spacing: 10,
                horizontalPadding: 14,
              ),
            ]),
          )),
          const SizedBox(height: 20),
          _sectionHeader('Popular this week', accent),
          SizedBox(height: 152, child: ListView.builder(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: colDefs.length, itemBuilder: (_, i) {
            final d = colDefs[i];
            final isLast = i == colDefs.length - 1;
            return GestureDetector(
              onTap: () => app.openList(d[0] as String),
              child: Container(
                width: 132,
                margin: EdgeInsets.only(right: isLast ? 0 : 10),
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(color: d[2] as Color, borderRadius: BorderRadius.circular(16)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    d[0] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF12261C)),
                  ),
                  const Spacer(),
                  Icon(d[1] as IconData, size: 34, color: const Color(0x4712261C)),
                ]),
              ),
            );
          })),
          const SizedBox(height: 20),
          _sectionHeader('Bestsellers for you', accent),
          const _ProductRow(
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
          ViewBasketBar(bottom: basketBottom),
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

  static Widget _iconBtn(IconData icon) => Container(width: 46, height: 46, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), boxShadow: const [BoxShadow(color: Color(0x12122612), blurRadius: 10, offset: Offset(0, 2))]), child: Icon(icon, size: 18, color: const Color(0xFF12261C)));

  static Widget _sectionHeader(String title, Color accent) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
    AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: accent),
      child: const Text('View all'),
    ),
  ])));

  static Widget _perk(String big, String small, String text) => Expanded(child: Row(children: [
    Container(constraints: const BoxConstraints(minWidth: 36, minHeight: 36), padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2), decoration: const BoxDecoration(color: Color(0xFFFFE9A8), shape: BoxShape.circle), alignment: Alignment.center, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(big, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF12261C), height: 1.1)),
      Text(small, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w600, color: Color(0x9912261C), height: 1.1)),
    ])),
    const SizedBox(width: 5),
    Expanded(child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Colors.white))),
  ]));

  static Widget _promoBanner(String title, String cta, Gradient gradient, Color titleColor, Color ctaColor) => Container(
    height: 96, padding: const EdgeInsets.all(14), decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: titleColor, height: 1.15)),
      const Spacer(),
      Row(mainAxisSize: MainAxisSize.min, children: [Text(cta, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: ctaColor)), const SizedBox(width: 4), Icon(Icons.arrow_forward, size: 11, color: ctaColor)]),
    ]),
  );

  static Widget _categoryBanner(BuildContext context, AppState app, String currentTab) {
    final banner = _categoryBanners[currentTab] ?? _categoryBanners['All']!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        child: Container(
          key: ValueKey<String>(currentTab),
          height: 152,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: banner.gradient,
            boxShadow: const [
              BoxShadow(
                color: Color(0x18122612),
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                right: -10,
                bottom: -15,
                child: Icon(
                  banner.icon,
                  size: 130,
                  color: banner.textColor.withValues(alpha: 0.08),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: banner.badgeBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        banner.badge,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: banner.badgeTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      banner.title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: banner.textColor,
                        height: 1.08,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      banner.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: banner.textColor.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => app.openList(banner.targetCategory),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: banner.buttonColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              banner.buttonText,
                              style: TextStyle(
                                color: banner.buttonTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward,
                              size: 12,
                              color: banner.buttonTextColor,
                            ),
                          ],
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
    );
  }
}

class _HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final CatTheme theme;
  final Color accent;
  final String selectedAddressLine;
  final String currentTab;
  final double topPadding;
  final AppState app;

  _HomeHeaderDelegate({
    required this.theme,
    required this.accent,
    required this.selectedAddressLine,
    required this.currentTab,
    required this.topPadding,
    required this.app,
  });

  static const double _topSectionHeight = 166.0;
  static const double _tabsHeight = 78.0;
  static const double _bottomGap = 6.0;

  @override
  double get maxExtent => topPadding + _topSectionHeight + _tabsHeight + _bottomGap;

  @override
  double get minExtent => topPadding + _tabsHeight + _bottomGap;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final clampedShrink = math.max(0.0, math.min(shrinkOffset, _topSectionHeight));
    final topOpacity = (1.0 - (clampedShrink / (_topSectionHeight * 0.75))).clamp(0.0, 1.0);
    final isPinned = shrinkOffset >= _topSectionHeight;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: theme.headerGradient,
        ),
        boxShadow: isPinned || overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: topPadding + 10 - clampedShrink,
              left: 16,
              right: 16,
              child: IgnorePointer(
                ignoring: topOpacity < 0.2,
                child: Opacity(
                  opacity: topOpacity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            'assests/1.png',
                            height: 40,
                            cacheHeight: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => showLocationSheet(context),
                              child: Row(
                                children: [
                                  TweenAnimationBuilder<Color?>(
                                    tween: ColorTween(end: accent),
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeInOutCubic,
                                    builder: (_, color, __) => Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DELIVERING TO',
                                          style: TextStyle(
                                            fontSize: 10.5,
                                            letterSpacing: .5,
                                            color: Colors.black.withValues(alpha: .55),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                selectedAddressLine,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF12261C),
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 16,
                                              color: Color(0xFF12261C),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => app.setScreen(Screen.account),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                size: 19,
                                color: Color(0xFF12261C),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x12122612),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.search, size: 18, color: Color(0xFF4C6157)),
                                  SizedBox(width: 9),
                                  Expanded(
                                    child: Text(
                                      "Search for 'milk'",
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        color: Color(0x6B12261C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          HomeScreen._iconBtn(Icons.receipt_long_outlined),
                          const SizedBox(width: 9),
                          HomeScreen._iconBtn(Icons.favorite_border),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: math.max(
                topPadding,
                topPadding + _topSectionHeight - clampedShrink,
              ),
              left: 0,
              right: 0,
              height: _tabsHeight,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: HomeScreen.tabDefs.length,
                itemBuilder: (_, i) {
                  final name = HomeScreen.tabDefs[i][0] as String;
                  final icon = HomeScreen.tabDefs[i][1] as IconData;
                  final on = currentTab == name;
                  return GestureDetector(
                    onTap: () => app.setTab(name),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOutCubic,
                      width: 74,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: on ? accent : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                            height: 44,
                            decoration: BoxDecoration(
                              color: on ? theme.tint : Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: on
                                  ? [
                                      BoxShadow(
                                        color: accent.withValues(alpha: 0.18),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : const [],
                            ),
                            child: Center(
                              child: TweenAnimationBuilder<Color?>(
                                tween: ColorTween(
                                  end: on ? accent : const Color(0xFF4C6157),
                                ),
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOutCubic,
                                builder: (_, color, __) => Icon(icon, color: color),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                            style: TextStyle(
                              fontSize: 11,
                              color: on ? accent : const Color(0x9912261C),
                              fontWeight: on ? FontWeight.w600 : FontWeight.w400,
                            ),
                            child: Text(name),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _HomeHeaderDelegate oldDelegate) {
    return oldDelegate.theme != theme ||
        oldDelegate.accent != accent ||
        oldDelegate.selectedAddressLine != selectedAddressLine ||
        oldDelegate.currentTab != currentTab ||
        oldDelegate.topPadding != topPadding;
  }
}

class _ProductRow extends StatelessWidget {
  final List<String> productIds;
  final double imageHeight;
  final double spacing;
  final double horizontalPadding;

  const _ProductRow({
    required this.productIds,
    this.imageHeight = 80,
    this.spacing = 10,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    // Sized to match "Popular this week" cards (width: 132, spacing: 10)
    const double cardWidth = 132.0;
    final double itemExtent = cardWidth + spacing;
    final double listHeight = imageHeight + 92.0;

    return SizedBox(
      height: listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: _SnapScrollPhysics(itemDimension: itemExtent),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: productIds.length,
        itemBuilder: (context, i) {
          final isLast = i == productIds.length - 1;
          return Padding(
            padding: EdgeInsets.only(right: isLast ? 0 : spacing),
            child: ProductCard(
              product: byId(productIds[i]),
              width: cardWidth,
              imageHeight: imageHeight,
            ),
          );
        },
      ),
    );
  }
}

class _SnapScrollPhysics extends ScrollPhysics {
  final double itemDimension;
  const _SnapScrollPhysics({required this.itemDimension, super.parent});

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapScrollPhysics(itemDimension: itemDimension, parent: buildParent(ancestor));
  }

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = position.pixels / itemDimension;
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return (page.roundToDouble() * itemDimension).clamp(position.minScrollExtent, position.maxScrollExtent);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }
    final Tolerance tolerance = toleranceFor(position);
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity, tolerance: tolerance);
    }
    return null;
  }
}
