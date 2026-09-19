import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/product_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/location_sheet.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = context.select<AppState, CatTheme>((s) => s.theme);
    final accent = context.select<AppState, Color>((s) => s.accent);
    final app = context.read<AppState>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      color: theme.solid,
      child: Column(children: [
        _HomeHeader(theme: theme, accent: accent),
        Expanded(
          child: Stack(
            children: [
              BottomNavScrollListener(
                child: ListView(padding: EdgeInsets.only(bottom: 104 + MediaQuery.paddingOf(context).bottom), children: [
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
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Container(
            height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFCFE4F7), Color(0xFFF3F1E4)])),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('FESTIVAL\nMITTHAAS KA', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF12261C), height: 1.05)),
              const SizedBox(height: 8),
              const Text('Starting @ ₹99', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Color(0xB312261C))),
              const SizedBox(height: 10),
              GestureDetector(onTap: () => app.openList('Festival mitthaas'), child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: const Color(0xFF12261C), borderRadius: BorderRadius.circular(100)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Text('Shop now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)), SizedBox(width: 6), Icon(Icons.arrow_forward, size: 13, color: Colors.white)]))),
            ]),
          )),
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
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Best deals for you', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                  const SizedBox(height: 3),
                  const Text('Fresh picks, up to 65% off · ends 9 pm', style: TextStyle(fontSize: 10.5, color: Color(0x8012261C))),
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
                imageHeight: 74,
                spacing: 8,
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
            imageHeight: 76,
            spacing: 8,
          ),
          const SizedBox(height: 22),
                ]),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BottomNav(),
              ),
            ],
          ),
        ),
      ]),
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
    Container(constraints: const BoxConstraints(minWidth: 44, minHeight: 44), padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3), decoration: const BoxDecoration(color: Color(0xFFFFE9A8), shape: BoxShape.circle), alignment: Alignment.center, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(big, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF12261C), height: 1.1)),
      Text(small, style: const TextStyle(fontSize: 7.5, fontWeight: FontWeight.w600, color: Color(0x9912261C), height: 1.1)),
    ])),
    const SizedBox(width: 8),
    Expanded(child: Text(text, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Colors.white))),
  ]));

  static Widget _promoBanner(String title, String cta, Gradient gradient, Color titleColor, Color ctaColor) => Container(
    height: 96, padding: const EdgeInsets.all(14), decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: titleColor, height: 1.15)),
      const Spacer(),
      Row(mainAxisSize: MainAxisSize.min, children: [Text(cta, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: ctaColor)), const SizedBox(width: 4), Icon(Icons.arrow_forward, size: 11, color: ctaColor)]),
    ]),
  );
}

class _HomeHeader extends StatelessWidget {
  final CatTheme theme;
  final Color accent;
  const _HomeHeader({required this.theme, required this.accent});

  @override
  Widget build(BuildContext context) {
    final addressVisible = context.select<AppState, bool>((s) => s.addressVisible);
    final selectedAddressLine = context.select<AppState, String>((s) => s.selectedAddress.line);
    final currentTab = context.select<AppState, String>((s) => s.tab);
    final app = context.read<AppState>();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      padding: EdgeInsets.fromLTRB(16, addressVisible ? 16 : 8, 16, addressVisible ? 12 : 8),
      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: theme.headerGradient)),
      child: SafeArea(bottom: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
        AnimatedCrossFade(
          firstChild: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Image.asset(
                      'assests/1.png',
                      height: 40,
                      cacheHeight: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(children: [
                  Expanded(child: GestureDetector(
                    onTap: () => showLocationSheet(context),
                    child: Row(children: [
                      TweenAnimationBuilder<Color?>(
                        tween: ColorTween(end: accent),
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOutCubic,
                        builder: (_, color, __) => Icon(Icons.location_on_outlined, size: 20, color: color),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('DELIVERING TO', style: TextStyle(fontSize: 10.5, letterSpacing: .5, color: Colors.black.withOpacity(.55))),
                        Row(children: [
                          Expanded(child: Text(selectedAddressLine, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Color(0xFF12261C)))),
                          const Icon(Icons.keyboard_arrow_down, size: 16, color: Color(0xFF12261C)),
                        ]),
                      ])),
                    ]),
                  )),
                  const SizedBox(width: 8),
                  Container(width: 38, height: 38, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.person_outline, size: 19, color: Color(0xFF12261C))),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: Container(height: 46, padding: const EdgeInsets.symmetric(horizontal: 12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), boxShadow: const [BoxShadow(color: Color(0x12122612), blurRadius: 10, offset: Offset(0, 2))]), child: const Row(children: [Icon(Icons.search, size: 18, color: Color(0xFF4C6157)), SizedBox(width: 9), Expanded(child: Text("Search for 'milk'", style: TextStyle(fontSize: 13.5, color: Color(0x6B12261C))))]))),
                  const SizedBox(width: 9),
                  HomeScreen._iconBtn(Icons.receipt_long_outlined),
                  const SizedBox(width: 9),
                  HomeScreen._iconBtn(Icons.favorite_border),
                ]),
                const SizedBox(height: 12),
              ],
            ),
          ),
          secondChild: const SizedBox(width: double.infinity, height: 0),
          crossFadeState: addressVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 260),
          sizeCurve: Curves.easeInOutCubic,
        ),
        SizedBox(height: 78, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: HomeScreen.tabDefs.length, itemBuilder: (_, i) {
          final name = HomeScreen.tabDefs[i][0] as String, icon = HomeScreen.tabDefs[i][1] as IconData;
          final on = currentTab == name;
          return GestureDetector(
            onTap: () => app.setTab(name),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
              width: 74, margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: on ? accent : Colors.transparent, width: 2.5))),
              child: Column(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  height: 44,
                  decoration: BoxDecoration(
                    color: on ? theme.tint : Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: on ? [BoxShadow(color: accent.withOpacity(0.18), blurRadius: 8, offset: const Offset(0, 3))] : const [],
                  ),
                  child: Center(
                    child: TweenAnimationBuilder<Color?>(
                      tween: ColorTween(end: on ? accent : const Color(0xFF4C6157)),
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
                  style: TextStyle(fontSize: 11, color: on ? accent : const Color(0x9912261C), fontWeight: on ? FontWeight.w600 : FontWeight.w400),
                  child: Text(name),
                ),
              ]),
            ),
          );
        })),
      ])),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final List<String> productIds;
  final double imageHeight;
  final double spacing;

  const _ProductRow({
    required this.productIds,
    this.imageHeight = 74,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        // The user specifically requested 3 products in one frame.
        // On very wide desktop displays (>= 768), show 4; on mobile/tablets, show exactly 3.
        final int count = totalWidth >= 768 ? 4 : 3;

        // Exactly size each card so that count cards + all paddings & gaps = totalWidth.
        // Formula: totalWidth = (count + 1) * spacing + count * cardWidth
        // => cardWidth = (totalWidth - (count + 1) * spacing) / count
        final double cardWidth = (totalWidth - ((count + 1) * spacing)) / count;
        final double itemExtent = cardWidth + spacing;
        final double listHeight = imageHeight + 116;

        return SizedBox(
          height: listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: _SnapScrollPhysics(itemDimension: itemExtent),
            padding: EdgeInsets.symmetric(horizontal: spacing),
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
      },
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
