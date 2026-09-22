import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../state/app_state.dart';

class CategoryBannerData {
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

  const CategoryBannerData({
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

const Map<String, CategoryBannerData> categoryBanners = {
  'All': CategoryBannerData(
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
  'Fresh': CategoryBannerData(
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
  'Grocery': CategoryBannerData(
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
  'Snacks': CategoryBannerData(
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
  'Beverages': CategoryBannerData(
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
  'Beauty': CategoryBannerData(
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

class HomeCategoryBanner extends StatelessWidget {
  final String currentTab;
  final AppState app;

  const HomeCategoryBanner({
    super.key,
    required this.currentTab,
    required this.app,
  });

  @override
  Widget build(BuildContext context) {
    final banner = categoryBanners[currentTab] ?? categoryBanners['All']!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        child: Container(
          key: ValueKey<String>(currentTab),
          height: 178,
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
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
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
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: banner.badgeTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      banner.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18.5,
                        fontWeight: FontWeight.w800,
                        color: banner.textColor,
                        height: 1.08,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      banner.subtitle,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: banner.textColor.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => app.openList(banner.targetCategory),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
                                fontSize: 12.5,
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
