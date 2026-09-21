import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../widgets/product_card.dart';
import '../widgets/view_basket_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const subDefs = [
    ['All', Icons.grid_view],
    ['Fresh vegetables', Icons.eco],
    ['Fresh fruits', Icons.apple],
    ['Herbs & seasoning', Icons.grass],
    ['Exotics', Icons.local_florist],
    ['Cuts & sprouts', Icons.spa],
    ['Organics', Icons.eco],
  ];

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final ids = subsets[app.sub] ?? subsets['All']!;
    final listProducts = ids.map(byId).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => app.setScreen(Screen.home),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6F4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFEDE8DE), width: 1),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 16,
                                color: Color(0xFF1E221E),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  app.sub == 'All' ? app.cat : app.sub,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E221E),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${listProducts.length * 7} items · delivered in 9 mins',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0x8A1E221E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F6F4),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFEDE8DE), width: 1),
                            ),
                            child: const Icon(
                              Icons.search,
                              size: 19,
                              color: Color(0xFF1E221E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (final f in [
                              'Sort',
                              'Veg only',
                              'Under ₹50',
                              'Organic',
                              'In 10 min'
                            ])
                              _filterChip(app, f),
                          ],
                        ),
                      ),
                      const SizedBox(height: 11),
                      const Divider(height: 1, color: Color(0xFFF0EFEA)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 82,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 120),
                        itemCount: subDefs.length,
                        itemBuilder: (_, i) {
                          final name = subDefs[i][0] as String;
                          final icon = subDefs[i][1] as IconData;
                          final on = app.sub == name;
                          return GestureDetector(
                            onTap: () => app.setSub(name),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: on ? app.theme.tint.withValues(alpha: .5) : Colors.transparent,
                                border: Border(
                                  left: BorderSide(
                                    color: on ? app.accent : Colors.transparent,
                                    width: 3.5,
                                  ),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: on ? app.theme.tint : const Color(0xFFF7F6F2),
                                      borderRadius: BorderRadius.circular(13),
                                      boxShadow: on
                                          ? [
                                              BoxShadow(
                                                color: app.accent.withValues(alpha: 0.18),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Icon(
                                      icon,
                                      size: 20,
                                      color: on ? app.accent : const Color(0xFF4C6157),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: on ? app.accent : const Color(0x991E221E),
                                      fontWeight: on ? FontWeight.w700 : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const VerticalDivider(width: 1, color: Color(0xFFF0EFEA)),
                    Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.fromLTRB(
                          12,
                          12,
                          12,
                          130 + MediaQuery.paddingOf(context).bottom,
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: .72,
                        ),
                        itemCount: listProducts.length,
                        itemBuilder: (_, i) => ProductCard(
                          product: listProducts[i],
                          width: double.infinity,
                          imageHeight: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          ViewBasketBar(bottom: 16 + MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }

  Widget _filterChip(AppState app, String name) {
    final on = app.filter == name;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => app.setFilter(name),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            color: on ? app.accent : const Color(0xFFF5F6F4),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: on ? app.accent : const Color(0xFFEDE8DE),
              width: 1,
            ),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 11.5,
              color: on ? Colors.white : const Color(0xFF1E221E),
              fontWeight: on ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
