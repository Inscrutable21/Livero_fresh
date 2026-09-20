import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../widgets/product_card.dart';
import '../widgets/view_basket_bar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const subDefs = [['All', Icons.grid_view], ['Fresh vegetables', Icons.eco], ['Fresh fruits', Icons.apple], ['Herbs & seasoning', Icons.grass], ['Exotics', Icons.local_florist], ['Cuts & sprouts', Icons.spa], ['Organics', Icons.eco]];

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final ids = subsets[app.sub] ?? subsets['All']!;
    final listProducts = ids.map(byId).toList();
    return Container(
      color: Colors.white,
      child: Stack(children: [
        Column(children: [
          SafeArea(bottom: false, child: Padding(padding: const EdgeInsets.fromLTRB(14, 14, 14, 0), child: Column(children: [
            Row(children: [
              GestureDetector(onTap: () => app.setScreen(Screen.home), child: Container(width: 34, height: 34, decoration: BoxDecoration(color: const Color(0xFFF2F4F1), borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF12261C)))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(app.sub == 'All' ? app.cat : app.sub, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                Text('${listProducts.length * 7} items · delivered in 9 mins', style: const TextStyle(fontSize: 10.5, color: Color(0x8012261C))),
              ])),
              const Icon(Icons.search, size: 19, color: Color(0xFF12261C)),
            ]),
            const SizedBox(height: 10),
            SizedBox(height: 34, child: ListView(scrollDirection: Axis.horizontal, children: [
              for (final f in ['Sort', 'Veg only', 'Under ₹50', 'Organic', 'In 10 min']) _filterChip(app, f),
            ])),
            const SizedBox(height: 11),
          ]))),
          Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(width: 80, child: ListView.builder(padding: const EdgeInsets.only(bottom: 120), itemCount: subDefs.length, itemBuilder: (_, i) {
              final name = subDefs[i][0] as String, icon = subDefs[i][1] as IconData;
              final on = app.sub == name;
              return GestureDetector(
                onTap: () => app.setSub(name),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(color: on ? app.theme.tint.withOpacity(.4) : Colors.transparent, border: Border(left: BorderSide(color: on ? app.accent : Colors.transparent, width: 3))),
                  child: Column(children: [
                    Container(width: 44, height: 44, decoration: BoxDecoration(color: on ? app.theme.tint : const Color(0xFFF4F5F2), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 20, color: on ? app.accent : const Color(0xFF4C6157))),
                    const SizedBox(height: 5),
                    Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 9.5, color: on ? app.accent : const Color(0x9912261C), fontWeight: on ? FontWeight.w600 : FontWeight.w400)),
                  ]),
                ),
              );
            })),
            Expanded(child: GridView.builder(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 130 + MediaQuery.paddingOf(context).bottom),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: .72),
              itemCount: listProducts.length,
              itemBuilder: (_, i) => ProductCard(product: listProducts[i], width: double.infinity, imageHeight: 100),
            )),
          ])),
        ]),
        ViewBasketBar(bottom: 16 + MediaQuery.paddingOf(context).bottom),
      ]),
    );
  }

  Widget _filterChip(AppState app, String name) {
    final on = app.filter == name;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => app.setFilter(name),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: on ? app.accent : const Color(0xFFF2F4F1), borderRadius: BorderRadius.circular(100), border: Border.all(color: on ? app.accent : const Color(0x14122612))),
          child: Text(name, style: TextStyle(fontSize: 11.5, color: on ? Colors.white : const Color(0xB312261C), fontWeight: on ? FontWeight.w600 : FontWeight.w400)),
        ),
      ),
    );
  }
}
