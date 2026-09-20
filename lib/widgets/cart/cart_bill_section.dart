import 'package:flutter/material.dart';

class CartBillSection extends StatelessWidget {
  final int cartTotal;
  final int cartSaved;
  final int deliveryFee;
  final int deliveryMrp;
  final int handlingFee;
  final int handlingMrp;
  final int grandTotal;
  final int totalSavings;
  final int awayFromFreeDelivery;

  const CartBillSection({
    super.key,
    required this.cartTotal,
    required this.cartSaved,
    required this.deliveryFee,
    this.deliveryMrp = 29,
    this.handlingFee = 12,
    this.handlingMrp = 15,
    required this.grandTotal,
    required this.totalSavings,
    required this.awayFromFreeDelivery,
  });

  @override
  Widget build(BuildContext context) {
    final itemsMrp = cartTotal + cartSaved;

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
          const Text(
            'Your Bill',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E221E),
            ),
          ),
          const SizedBox(height: 14),

          // Items total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Items total',
                style: TextStyle(fontSize: 13.5, color: Color(0xFF2C322C)),
              ),
              Row(
                children: [
                  Text(
                    '₹$itemsMrp',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E948F),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '₹$cartTotal',
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
          const SizedBox(height: 10),

          // Delivery Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Delivery Fee',
                style: TextStyle(fontSize: 13.5, color: Color(0xFF2C322C)),
              ),
              Row(
                children: [
                  Text(
                    '₹$deliveryMrp',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E948F),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    deliveryFee == 0 ? 'FREE' : '₹$deliveryFee',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: deliveryFee == 0 ? const Color(0xFF0F8A4B) : const Color(0xFF1E221E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (deliveryFee > 0) ...[
            const SizedBox(height: 3),
            Text(
              'Shop for ₹$awayFromFreeDelivery to unlock free delivery',
              style: const TextStyle(
                fontSize: 11.5,
                color: Color(0xFF0F8A4B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const SizedBox(height: 10),

          // Handling Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Handling Fee',
                style: TextStyle(fontSize: 13.5, color: Color(0xFF2C322C)),
              ),
              Row(
                children: [
                  Text(
                    '₹$handlingMrp',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E948F),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '₹$handlingFee',
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, color: Color(0xFFEDE9E0)),
          ),

          // Grand total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand total',
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E221E),
                ),
              ),
              Text(
                '₹$grandTotal',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E221E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Savings Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F6EE),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              'You are saving ₹$totalSavings on this order',
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F8A4B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
