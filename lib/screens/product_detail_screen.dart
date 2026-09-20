import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../widgets/view_basket_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const packLabels = ['250 g', null, '2× pack'];
  static const packMults = [0.55, 1.0, 1.85];

  static const benefits = [
    ['Farm to door', 'Harvested within 24 hours', Color(0xFFCDE9D6)],
    ['Hand sorted', 'Graded at the dark store', Color(0xFFFBE3C0)],
    ['Cold chain', 'Held at 4°C till dispatch', Color(0xFFD6E4F7)],
    ['Easy returns', 'Not fresh? Instant refund', Color(0xFFEFDAE9)],
  ];

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final p = byId(app.pid);
    final mult = packMults[app.pack];
    final unit = app.pack == 1 ? p.unit : packLabels[app.pack]!;
    final price = (p.price * mult).round();
    final mrp = (p.mrp * mult).round();
    final qty = app.cart[p.id] ?? 0;
    final similar = products.where((x) => x.id != p.id).take(5).toList();

    return Container(
      color: Colors.white,
      child: Stack(children: [
        Column(children: [
          Expanded(child: ListView(children: [
            Stack(children: [
              Container(height: 300, color: p.color, child: Center(child: Icon(p.icon, size: 110, color: app.accent.withOpacity(.35)))),
              SafeArea(bottom: false, child: Padding(padding: const EdgeInsets.fromLTRB(14, 6, 14, 0), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(onTap: () => app.setScreen(Screen.list), child: _roundBtn(Icons.arrow_back_ios_new)),
                Row(children: [_roundBtn(Icons.favorite_border), const SizedBox(width: 8), _roundBtn(Icons.share_outlined)]),
              ]))),
            ]),
            Container(
              transform: Matrix4.translationValues(0, -22, 0),
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.brand.toUpperCase(), style: const TextStyle(fontSize: 10, letterSpacing: .8, fontWeight: FontWeight.w600, color: Color(0x8012261C))),
                const SizedBox(height: 8),
                Text(p.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                const SizedBox(height: 9),
                Row(children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFEAF6EF), borderRadius: BorderRadius.circular(7)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.star, size: 12, color: Color(0xFF0E7A4B)), SizedBox(width: 4), Text('4.5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF0A5C39)))])),
                  const SizedBox(width: 9),
                  const Text('2,481 ratings', style: TextStyle(fontSize: 10.5, color: Color(0x8012261C))),
                ]),
                const SizedBox(height: 16),
                Row(children: [
                  _packOption(app, 0, '250 g', (p.price * 0.55).round()),
                  const SizedBox(width: 8),
                  _packOption(app, 1, p.unit, p.price),
                  const SizedBox(width: 8),
                  _packOption(app, 2, '2× pack', (p.price * 1.85).round()),
                ]),
                const SizedBox(height: 18),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('₹' + price.toString(), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                  const SizedBox(width: 9),
                  Text('₹' + mrp.toString(), style: const TextStyle(fontSize: 13, color: Color(0x6B12261C), decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 9),
                  Text(p.off.toString() + '% off', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: app.accent)),
                ]),
                const SizedBox(height: 6),
                const Text('Inclusive of all taxes', style: TextStyle(fontSize: 10.5, color: Color(0x7312261C))),
                const SizedBox(height: 16),
                Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF2F8F4), borderRadius: BorderRadius.circular(14)), child: Row(children: [
                  Container(width: 32, height: 32, decoration: BoxDecoration(color: const Color(0xFF0E7A4B), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.bolt, size: 17, color: Colors.white)),
                  const SizedBox(width: 9),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Delivered in 9 minutes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF12261C))),
                    const Text('From Kondhwa dark store · free over ₹199', style: TextStyle(fontSize: 10.5, color: Color(0x8012261C))),
                  ])),
                ])),
                const SizedBox(height: 20),
                const Text("Why you'll like it", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                const SizedBox(height: 11),
                GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), mainAxisSpacing: 9, crossAxisSpacing: 9, childAspectRatio: 1.9, children: [
                  for (final b in benefits) _benefitTile(b[0] as String, b[1] as String, b[2] as Color),
                ]),
                const SizedBox(height: 20),
                const Text('Product details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                const SizedBox(height: 10),
                Container(decoration: BoxDecoration(border: Border.all(color: const Color(0x12122612)), borderRadius: BorderRadius.circular(14)), clipBehavior: Clip.antiAlias, child: Column(children: [
                  _specRow('Brand', p.brand, 0),
                  _specRow('Unit', unit, 1),
                  _specRow('Shelf life', '4 days from delivery', 2),
                  _specRow('Storage', 'Refrigerate below 8°C', 3),
                  _specRow('Country of origin', 'India', 4),
                ])),
                const SizedBox(height: 22),
                const Text('Often bought together', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
                const SizedBox(height: 12),
                SizedBox(height: 96, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: similar.length, itemBuilder: (_, i) => Padding(padding: const EdgeInsets.only(right: 10), child: SizedBox(width: 90, child: Container(decoration: BoxDecoration(color: similar[i].color, borderRadius: BorderRadius.circular(12)), child: Icon(similar[i].icon, color: app.accent.withOpacity(.5))))))),
                const SizedBox(height: 130),
              ]),
            ),
          ])),
        ]),
        Positioned(left: 0, right: 0, bottom: 0, child: Container(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 28),
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white.withOpacity(0), Colors.white]), color: Colors.white),
          child: SafeArea(top: false, child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('₹' + price.toString(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
              Text(unit, style: const TextStyle(fontSize: 10, color: Color(0x7312261C))),
            ]),
            const SizedBox(width: 12),
            Expanded(child: GestureDetector(
              onTap: () => app.add(p.id),
              child: Container(height: 52, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [Color(0xFF0A5C39), Color(0xFF12A05F)]), boxShadow: const [BoxShadow(color: Color(0x520A5C39), blurRadius: 22, offset: Offset(0, 8))]), alignment: Alignment.center, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.shopping_cart_outlined, size: 17, color: Colors.white),
                const SizedBox(width: 8),
                Text(qty > 0 ? 'In basket · ' + qty.toString() + '  |  Add more' : 'Add to basket', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
              ])),
            )),
          ])),
        )),
        ViewBasketBar(bottom: 86 + MediaQuery.paddingOf(context).bottom),
      ]),
    );
  }

  static Widget _roundBtn(IconData icon) => Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(.92), borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Color(0x1F122612), blurRadius: 8, offset: Offset(0, 2))]), child: Icon(icon, size: 17, color: const Color(0xFF12261C)));

  Widget _packOption(AppState app, int i, String label, int price) {
    final on = app.pack == i;
    return Expanded(child: GestureDetector(
      onTap: () => app.setPack(i),
      child: Container(padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: on ? const Color(0xFFEAF6EF) : Colors.white, border: Border.all(color: on ? app.accent : const Color(0x1F122612), width: 1.4), borderRadius: BorderRadius.circular(12)), child: Column(children: [
        Text(label, style: TextStyle(fontSize: 12, color: on ? const Color(0xFF0A5C39) : const Color(0xA6122612))),
        const SizedBox(height: 5),
        Text('₹' + price.toString(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: on ? const Color(0xFF0A5C39) : const Color(0xA6122612))),
      ])),
    ));
  }

  Widget _benefitTile(String title, String text, Color c) => Container(padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: const Color(0xFFF6F7F4), borderRadius: BorderRadius.circular(13), border: Border.all(color: const Color(0x0D122612))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
    Container(width: 22, height: 22, decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(7))),
    const SizedBox(height: 9),
    Text(title, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF12261C))),
    Text(text, style: const TextStyle(fontSize: 10, color: Color(0x8012261C))),
  ]));

  Widget _specRow(String k, String v, int i) => Container(color: i % 2 == 1 ? const Color(0xFFFAFBF9) : Colors.white, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11), child: Row(children: [
    SizedBox(width: 130, child: Text(k, style: const TextStyle(fontSize: 11, color: Color(0x8012261C)))),
    Expanded(child: Text(v, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF12261C)))),
  ]));
}
