import 'package:flutter/material.dart';

class CartDeliveryBanner extends StatelessWidget {
  final int awayFromFreeDelivery;
  final int cartTotal;
  final int freeDeliveryThreshold;

  const CartDeliveryBanner({
    super.key,
    required this.awayFromFreeDelivery,
    required this.cartTotal,
    this.freeDeliveryThreshold = 340,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.inventory_2_outlined, size: 16, color: Color(0xFF0F5A38)),
              const SizedBox(width: 6),
              Text(
                awayFromFreeDelivery > 0
                    ? '₹$awayFromFreeDelivery away to unlock Free Delivery'
                    : '🎉 Free Delivery Unlocked!',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F5A38),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: (cartTotal / freeDeliveryThreshold).clamp(0.04, 1.0),
              minHeight: 3,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF0F5A38)),
            ),
          ),
        ],
      ),
    );
  }
}
