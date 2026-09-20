import 'package:flutter/material.dart';

class DealItem {
  final String id;
  final String name;
  final String unit;
  final int price;
  final int mrp;
  final int targetAmount;
  final Color color;
  final IconData icon;
  final String? badge;

  const DealItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.mrp,
    required this.targetAmount,
    required this.color,
    required this.icon,
    this.badge,
  });
}

class CartDealsSection extends StatelessWidget {
  final List<DealItem> deals;

  const CartDealsSection({
    super.key,
    this.deals = defaultDeals,
  });

  static const List<DealItem> defaultDeals = [
    DealItem(
      id: 'ghee_a2',
      name: 'GoSwasthya A2 Cow Ghee',
      unit: '150 ml',
      price: 99,
      mrp: 399,
      targetAmount: 2428,
      color: Color(0xFFFFF9E6),
      icon: Icons.local_drink,
      badge: null,
    ),
    DealItem(
      id: 'incense',
      name: 'Art of Puja Rainforest Incense...',
      unit: '10 Sticks',
      price: 59,
      mrp: 109,
      targetAmount: 428,
      color: Color(0xFFE8F5E9),
      icon: Icons.spa,
      badge: 'Only 2 left!',
    ),
    DealItem(
      id: 'tea',
      name: 'Tata Premium Leaf Gold Tea',
      unit: '500 g',
      price: 189,
      mrp: 270,
      targetAmount: 650,
      color: Color(0xFFFBE9E7),
      icon: Icons.emoji_food_beverage,
      badge: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Deals of the day',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E221E),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.verified, size: 16, color: Color(0xFF2A85FF)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF3F779E), width: 1.1),
                  ),
                  child: const Text(
                    '0 of 3 deals unlocked',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF21567C),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal Deals List
          SizedBox(
            height: 200,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: deals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, i) {
                final deal = deals[i];
                return Container(
                  width: 154,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEDE9E0), width: 1.1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image Area
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              color: deal.color,
                              alignment: Alignment.center,
                              child: Icon(deal.icon, size: 36, color: Colors.black38),
                            ),
                            if (deal.badge != null)
                              Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A85FF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    deal.badge!,
                                    style: const TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Item Details
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deal.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E221E),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              deal.unit,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF757A75),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F1FB),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '₹${deal.price}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1B65A8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '₹${deal.mrp}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF8E948F),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFC7CBD1)),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.lock_outline, size: 14, color: Color(0xFF6B7280)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Bottom "Shop for ₹... more" bar
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        color: const Color(0xFFEAF2FB),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock, size: 10, color: Color(0xFF1E64A5)),
                            const SizedBox(width: 4),
                            Text(
                              'Shop for ₹${deal.targetAmount} more',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E64A5),
                              ),
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
