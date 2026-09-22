import 'package:flutter/material.dart';
import '../../models.dart';
import '../product_card.dart';

class HomeProductRow extends StatelessWidget {
  final List<String> productIds;
  final double imageHeight;
  final double spacing;
  final double horizontalPadding;

  const HomeProductRow({
    super.key,
    required this.productIds,
    this.imageHeight = 80,
    this.spacing = 10,
    this.horizontalPadding = 16,
  });

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 132.0;
    final double itemExtent = cardWidth + spacing;
    final double listHeight = imageHeight + 104.0;

    return SizedBox(
      height: listHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: SnapScrollPhysics(itemDimension: itemExtent),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
  }
}

class SnapScrollPhysics extends ScrollPhysics {
  final double itemDimension;
  const SnapScrollPhysics({required this.itemDimension, super.parent});

  @override
  SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnapScrollPhysics(itemDimension: itemDimension, parent: buildParent(ancestor));
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
