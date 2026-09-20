import 'package:flutter/material.dart';
import '../../models.dart';
import '../../state/app_state.dart';

class CartReviewItems extends StatelessWidget {
  final AppState app;
  final List<MapEntry<String, int>> cartEntries;

  const CartReviewItems({
    super.key,
    required this.app,
    required this.cartEntries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Review items',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E221E),
                ),
              ),
              Text(
                '${cartEntries.length} ${cartEntries.length == 1 ? 'item' : 'items'}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF757A75),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (cartEntries.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.shopping_basket_outlined, size: 40, color: Color(0xFFB0B5B0)),
                    SizedBox(height: 8),
                    Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E221E)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Add items from below or browse more',
                      style: TextStyle(fontSize: 12, color: Color(0xFF757A75)),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartEntries.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFF0EBE1)),
              ),
              itemBuilder: (ctx, i) {
                final entry = cartEntries[i];
                final key = entry.key;
                final qty = entry.value;

                final sep = key.indexOf('::');
                final pidPart = sep < 0 ? key : key.substring(0, sep);
                final vIdx = sep < 0 ? null : int.parse(key.substring(sep + 2));
                final p = byId(pidPart);
                final v = (vIdx != null && p.variants != null) ? p.variants![vIdx] : null;

                final label = v != null ? '${v.label} x $qty' : '${p.unit} x $qty';
                final price = v != null ? v.price : p.price;
                final mrp = v != null ? v.mrp : p.mrp;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product image container
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: p.color,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE8E5DD)),
                      ),
                      alignment: Alignment.center,
                      child: Icon(p.icon, size: 26, color: Colors.black45),
                    ),
                    const SizedBox(width: 12),

                    // Title & Unit
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E221E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757A75),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stepper & Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Stepper Pill
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFDCDFD8), width: 1.1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => app.bump(key, -1),
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Icon(Icons.remove, size: 15, color: Color(0xFF1E221E)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  '$qty',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E221E),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => app.bump(key, 1),
                                borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Icon(Icons.add, size: 15, color: Color(0xFF1E221E)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Price Row
                        Row(
                          children: [
                            Text(
                              '₹${mrp * qty}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8E948F),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '₹${price * qty}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E221E),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
