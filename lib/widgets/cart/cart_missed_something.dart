import 'package:flutter/material.dart';

class CartMissedSomething extends StatelessWidget {
  final VoidCallback? onAddMore;

  const CartMissedSomething({
    super.key,
    this.onAddMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Missed something? ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E221E),
            ),
          ),
          GestureDetector(
            onTap: onAddMore ?? () => Navigator.maybePop(context),
            child: const Text(
              'Add more items',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F8A4B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
