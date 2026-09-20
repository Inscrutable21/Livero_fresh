import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';

void showBasketSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const _BasketSheet(),
  );
}

class _BasketSheet extends StatelessWidget {
  const _BasketSheet();

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final cartEntries = app.cart.entries.toList();
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.82,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 6),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0x26122612),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 14, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Basket',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF12261C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${app.cartCount} items · Delivery in 9 mins',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0x8012261C),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F4F1),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: Color(0xFF12261C),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0x14122612)),
          // Items & bill
          if (cartEntries.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Icon(
                    Icons.shopping_basket_outlined,
                    size: 54,
                    color: Color(0x4012261C),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your basket is empty',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF12261C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Add fresh groceries to get started',
                    style: TextStyle(fontSize: 12, color: Color(0x8012261C)),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      app.setScreen(Screen.home);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E7A4B),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Shop now'),
                  ),
                ],
              ),
            )
          else
            Flexible(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                shrinkWrap: true,
                children: [
                  // Item list
                  for (final entry in cartEntries) _itemTile(app, entry.key, entry.value),
                  const SizedBox(height: 14),
                  // Bill details
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAF7),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0x12122612)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bill Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF12261C),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _billRow('Items total', '₹${app.cartTotal}'),
                        const SizedBox(height: 6),
                        _billRow('Delivery partner fee', 'FREE', isHighlight: true),
                        const SizedBox(height: 6),
                        _billRow('Handling charge', '₹2'),
                        const SizedBox(height: 6),
                        _billRow('Total savings', '−₹${app.cartSaved}', isDiscount: true),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Divider(height: 1, color: Color(0x1F122612)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'To Pay',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF12261C),
                              ),
                            ),
                            Text(
                              '₹${app.cartTotal + 2}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0E7A4B),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          // Bottom checkout bar
          if (cartEntries.isNotEmpty)
            Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset > 0 ? bottomInset + 8 : 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x12122612),
                    blurRadius: 10,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order placed for ₹${app.cartTotal + 2}! Arriving in 9 mins.'),
                      backgroundColor: const Color(0xFF0E7A4B),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A5C39), Color(0xFF12A05F)],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x400A5C39),
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹${app.cartTotal + 2}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: Color(0xBFFFFFFF),
                              letterSpacing: .5,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Proceed to Pay',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _itemTile(AppState app, String key, int qty) {
    final meta = app.keyMeta(key);
    final i = key.indexOf('::');
    final pid = i < 0 ? key : key.substring(0, i);
    final p = byId(pid);
    final vIdx = i < 0 ? null : int.parse(key.substring(i + 2));
    final unit = (vIdx != null && p.variants != null) ? p.variants![vIdx].label : p.unit;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: p.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(p.icon, size: 22, color: app.accent.withOpacity(.6)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF12261C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: Color(0x8012261C),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      '₹${meta.price}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF12261C),
                      ),
                    ),
                    if (meta.mrp > meta.price) ...[
                      const SizedBox(width: 6),
                      Text(
                        '₹${meta.mrp}',
                        style: const TextStyle(
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                          color: Color(0x6B12261C),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 28,
            decoration: BoxDecoration(
              color: app.accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => app.bump(key, -1),
                  child: const SizedBox(
                    width: 26,
                    height: 28,
                    child: Center(
                      child: Text('−', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Container(
                  width: 22,
                  alignment: Alignment.center,
                  child: Text(
                    qty.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                GestureDetector(
                  onTap: () => app.bump(key, 1),
                  child: const SizedBox(
                    width: 26,
                    height: 28,
                    child: Center(
                      child: Text('+', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value, {bool isHighlight = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11.5, color: Color(0x9912261C)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: isHighlight || isDiscount ? FontWeight.w600 : FontWeight.w500,
            color: isDiscount
                ? const Color(0xFF0E7A4B)
                : isHighlight
                    ? const Color(0xFF0E7A4B)
                    : const Color(0xFF12261C),
          ),
        ),
      ],
    );
  }
}
