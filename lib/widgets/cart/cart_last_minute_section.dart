import 'package:flutter/material.dart';

class LastMinuteItem {
  final String id;
  final String brand;
  final String name;
  final String unit;
  final int price;
  final int mrp;
  final Color bgColor;
  final IconData icon;

  const LastMinuteItem({
    required this.id,
    required this.brand,
    required this.name,
    required this.unit,
    required this.price,
    required this.mrp,
    required this.bgColor,
    required this.icon,
  });
}

class CartLastMinuteSection extends StatefulWidget {
  final void Function(String id) onAdd;

  const CartLastMinuteSection({
    super.key,
    required this.onAdd,
  });

  @override
  State<CartLastMinuteSection> createState() => _CartLastMinuteSectionState();
}

class _CartLastMinuteSectionState extends State<CartLastMinuteSection> {
  int _currentTab = 0;

  static const List<String> tabs = ['Sweet Treats', 'Fruits & Veggies', 'Snacks'];

  static const Map<int, List<LastMinuteItem>> itemsByTab = {
    0: [
      LastMinuteItem(
        id: 'taali',
        brand: 'TAALI',
        name: 'Digestive High Fibre Biscuits',
        unit: '100 g',
        price: 29,
        mrp: 35,
        bgColor: Color(0xFFE8DEF8),
        icon: Icons.cookie_outlined,
      ),
      LastMinuteItem(
        id: 'motichur',
        brand: 'SANGAM',
        name: 'Motichur Laddu',
        unit: '200 g',
        price: 114,
        mrp: 180,
        bgColor: Color(0xFFFFF3D6),
        icon: Icons.cake_outlined,
      ),
      LastMinuteItem(
        id: 'chocolate',
        brand: 'MMMELT',
        name: 'Rum & Raisins 55% Dark',
        unit: '30 g',
        price: 59,
        mrp: 89,
        bgColor: Color(0xFFECE0D8),
        icon: Icons.takeout_dining_outlined,
      ),
    ],
    1: [
      LastMinuteItem(
        id: 'banana',
        brand: 'LIVERO FRESH',
        name: 'Robusta Banana',
        unit: '6 pcs',
        price: 44,
        mrp: 58,
        bgColor: Color(0xFFFFF9DB),
        icon: Icons.eco_outlined,
      ),
      LastMinuteItem(
        id: 'spinach',
        brand: 'ORGANIC FARMS',
        name: 'Palak — Bunch',
        unit: '250 g',
        price: 18,
        mrp: 30,
        bgColor: Color(0xFFE8F5E9),
        icon: Icons.grass_outlined,
      ),
      LastMinuteItem(
        id: 'tomato',
        brand: 'LOCAL HARVEST',
        name: 'Tomato — Local',
        unit: '500 g',
        price: 16,
        mrp: 42,
        bgColor: Color(0xFFFFEBEE),
        icon: Icons.circle_outlined,
      ),
    ],
    2: [
      LastMinuteItem(
        id: 'bread',
        brand: 'BRITANNIA',
        name: 'Whole Wheat Bread',
        unit: '400 g',
        price: 45,
        mrp: 55,
        bgColor: Color(0xFFFFF3E0),
        icon: Icons.bakery_dining_outlined,
      ),
      LastMinuteItem(
        id: 'potato',
        brand: 'FARMS BEST',
        name: 'Potato — New Crop',
        unit: '1 kg',
        price: 10,
        mrp: 27,
        bgColor: Color(0xFFF5F0E4),
        icon: Icons.grain_outlined,
      ),
      LastMinuteItem(
        id: 'carrot',
        brand: 'OOTY SPECIAL',
        name: 'Carrot — Ooty Sweet',
        unit: '500 g',
        price: 20,
        mrp: 48,
        bgColor: Color(0xFFFFEEDB),
        icon: Icons.eco,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentItems = itemsByTab[_currentTab] ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Last minute additions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E221E),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Tabs Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(tabs.length, (idx) {
                final isSelected = _currentTab == idx;
                return GestureDetector(
                  onTap: () => setState(() => _currentTab = idx),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? const Color(0xFF1E221E) : Colors.transparent,
                          width: 2.2,
                        ),
                      ),
                    ),
                    child: Text(
                      tabs[idx],
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? const Color(0xFF1E221E) : const Color(0xFF8E948F),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal Products List
          SizedBox(
            height: 196,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: currentItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, i) {
                final item = currentItems[i];
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEDE9E0), width: 1.1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image with floating Add (+) button
                      SizedBox(
                        height: 94,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 94,
                              color: item.bgColor,
                              alignment: Alignment.center,
                              child: Icon(item.icon, size: 38, color: Colors.black45),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: GestureDetector(
                                onTap: () => widget.onAdd(item.id),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x30000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.add, size: 18, color: Color(0xFF1E221E)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Item Details
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.brand,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF9E9E9E),
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E221E),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.unit,
                              style: const TextStyle(
                                fontSize: 10.5,
                                color: Color(0xFF757A75),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '₹ ${item.price}',
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E221E),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '₹ ${item.mrp}',
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    color: Color(0xFF8E948F),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
