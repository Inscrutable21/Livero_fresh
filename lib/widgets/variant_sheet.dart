import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';

void showVariantSheet(BuildContext context, String productId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _VariantSheet(productId: productId),
  );
}

class _VariantSheet extends StatelessWidget {
  final String productId;
  const _VariantSheet({required this.productId});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final p = byId(productId);
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 22),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(child: Text(p.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF12261C)))),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(width: 28, height: 28, decoration: const BoxDecoration(color: Color(0xFFF2F4F1), shape: BoxShape.circle), alignment: Alignment.center, child: const Text('×', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF12261C)))),
            ),
          ]),
          const SizedBox(height: 14),
          for (var i = 0; i < p.variants!.length; i++) _row(context, app, p, i),
        ]),
      ),
    );
  }

  Widget _row(BuildContext context, AppState app, Product p, int i) {
    final v = p.variants![i];
    final key = '${p.id}::$i';
    final qty = app.cart[key] ?? 0;
    final highlighted = i == 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: highlighted ? app.accent : const Color(0x1F122612), width: 1.5),
        boxShadow: highlighted ? const [BoxShadow(color: Color(0x1A122612), blurRadius: 14, offset: Offset(0, 4))] : null,
      ),
      child: Stack(clipBehavior: Clip.none, children: [
        if (highlighted)
          Positioned(top: -21, left: 2, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF0E7A4B), borderRadius: BorderRadius.circular(6)), child: Text('Save ₹${v.mrp - v.price}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)))),
        Row(children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: p.color, borderRadius: BorderRadius.circular(10)), child: Icon(p.icon, color: app.accent.withValues(alpha: .5))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(v.label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF12261C))),
            const SizedBox(height: 3),
            Row(children: [
              Text('₹${v.price}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
              const SizedBox(width: 6),
              Text('₹${v.mrp}', style: const TextStyle(fontSize: 11, color: Color(0x6B12261C), decoration: TextDecoration.lineThrough)),
            ]),
          ])),
          Container(
            width: 78, height: 34,
            decoration: BoxDecoration(border: Border.all(color: app.accent, width: 1.4), borderRadius: BorderRadius.circular(9)),
            child: qty == 0
              ? GestureDetector(onTap: () => app.add(key), child: Container(alignment: Alignment.center, child: Text('ADD', style: TextStyle(color: app.accent, fontWeight: FontWeight.w600, fontSize: 12.5))))
              : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  GestureDetector(onTap: () => app.bump(key, -1), child: Text('−', style: TextStyle(color: app.accent, fontWeight: FontWeight.w600, fontSize: 15))),
                  Text(qty.toString(), style: TextStyle(color: app.accent, fontWeight: FontWeight.w600, fontSize: 12)),
                  GestureDetector(onTap: () => app.bump(key, 1), child: Text('+', style: TextStyle(color: app.accent, fontWeight: FontWeight.w600, fontSize: 15))),
                ]),
          ),
        ]),
      ]),
    );
  }
}
