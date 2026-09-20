import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import 'variant_sheet.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double width;
  final double? height;
  final double imageHeight;
  const ProductCard({super.key, required this.product, this.width = 132, this.height, this.imageHeight = 80});

  @override
  Widget build(BuildContext context) {
    final accent = context.select<AppState, Color>((s) => s.accent);
    final tint = context.select<AppState, Color>((s) => s.theme.tint);
    final qty = context.select<AppState, int>((s) => s.qtyFor(product.id));
    final app = context.read<AppState>();
    final hasVariants = product.variants != null && product.variants!.length > 1;
    final isCompact = width < 145;
    return GestureDetector(
      onTap: () => app.openProduct(product.id),
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0D122612), blurRadius: 4, offset: Offset(0, 1))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(children: [
              Container(
                height: imageHeight,
                width: double.infinity,
                color: product.color,
                child: Center(
                  child: Icon(product.icon, size: imageHeight * 0.44, color: accent.withOpacity(.55)),
                ),
              ),
              if (product.off > 10)
                Positioned(
                  left: 0, top: isCompact ? 5 : 8,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(isCompact ? 4 : 6, isCompact ? 2 : 4, isCompact ? 4 : 7, isCompact ? 2 : 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E7A4B),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(isCompact ? 4 : 6),
                        bottomRight: Radius.circular(isCompact ? 4 : 6),
                      ),
                    ),
                    child: Text(
                      '${product.off}% OFF',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: isCompact ? 8.0 : 9.5),
                    ),
                  ),
                ),
            ]),
            Padding(
              padding: EdgeInsets.fromLTRB(isCompact ? 8 : 10, isCompact ? 6 : 8, isCompact ? 8 : 10, isCompact ? 8 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: isCompact ? 28 : 34,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isCompact ? 11.0 : 12.0, fontWeight: FontWeight.w500, color: const Color(0xFF12261C), height: 1.15),
                    ),
                  ),
                  const SizedBox(height: 2),
                  SizedBox(
                    height: isCompact ? 13 : 15,
                    child: Text(
                      product.unit,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: isCompact ? 9.0 : 10.5, color: const Color(0x8812261C)),
                    ),
                  ),
                  SizedBox(height: isCompact ? 5 : 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('₹${product.price}', style: TextStyle(fontSize: isCompact ? 11.5 : 14, fontWeight: FontWeight.w700, color: const Color(0xFF12261C), height: 1.1), overflow: TextOverflow.ellipsis),
                            Text('₹${product.mrp}', style: TextStyle(fontSize: isCompact ? 8.5 : 10, color: const Color(0x6B12261C), decoration: TextDecoration.lineThrough, height: 1.1), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      const SizedBox(width: 2),
                      SizedBox(
                        height: isCompact ? 24 : 34,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _cta(context, app, hasVariants, qty, accent, tint, compact: isCompact),
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
    );
  }

  Widget _cta(BuildContext context, AppState app, bool hasVariants, int qty, Color accent, Color tint, {bool compact = false}) {
    if (hasVariants) {
      if (qty > 0) {
        return GestureDetector(
          onTap: () => showVariantSheet(context, product.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
            height: compact ? 22 : 26,
            padding: EdgeInsets.symmetric(horizontal: compact ? 5 : 6),
            decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(compact ? 6 : 8)),
            alignment: Alignment.center,
            child: Text(qty.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: compact ? 10.5 : 12)),
          ),
        );
      }
      return GestureDetector(
        onTap: () => showVariantSheet(context, product.id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
          height: compact ? 24 : 34,
          width: compact ? 42 : 64,
          decoration: BoxDecoration(border: Border.all(color: accent.withOpacity(.4), width: 1.3), borderRadius: BorderRadius.circular(compact ? 6 : 8), color: tint.withOpacity(.25)),
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
              style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: compact ? 9.5 : 12, height: 1.0),
              child: const Text('ADD'),
            ),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
              style: TextStyle(color: accent.withOpacity(.75), fontSize: compact ? 6.5 : 8, height: 1.0),
              child: Text(compact ? '${product.variants!.length} opts' : '${product.variants!.length} options'),
            ),
          ]),
        ),
      );
    }
    if (qty > 0) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
        height: compact ? 22 : 26,
        decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(compact ? 6 : 8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          _stepBtn('−', () => app.bump(product.id, -1), compact: compact),
          Container(width: compact ? 14 : 20, alignment: Alignment.center, child: Text(qty.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: compact ? 10.5 : 12))),
          _stepBtn('+', () => app.bump(product.id, 1), compact: compact),
        ]),
      );
    }
    return GestureDetector(
      onTap: () => app.add(product.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
        height: compact ? 22 : 26,
        width: compact ? 36 : 52,
        decoration: BoxDecoration(border: Border.all(color: accent.withOpacity(.4), width: 1.3), borderRadius: BorderRadius.circular(compact ? 6 : 8), color: tint.withOpacity(.25)),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubic,
          style: TextStyle(color: accent, fontWeight: FontWeight.w700, fontSize: compact ? 10 : 12, height: 1.0),
          child: const Text('ADD'),
        ),
      ),
    );
  }

  Widget _stepBtn(String label, VoidCallback onTap, {bool compact = false}) => GestureDetector(
    onTap: onTap,
    child: SizedBox(
      width: compact ? 14 : 20,
      height: compact ? 22 : 26,
      child: Center(child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: compact ? 13 : 15))),
    ),
  );
}
