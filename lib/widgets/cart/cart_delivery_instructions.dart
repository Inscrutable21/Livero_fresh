import 'package:flutter/material.dart';

class CartDeliveryInstructions extends StatelessWidget {
  final Set<int> selectedInstructions;
  final void Function(int index) onToggle;

  const CartDeliveryInstructions({
    super.key,
    required this.selectedInstructions,
    required this.onToggle,
  });

  static const List<(IconData, String)> instructions = [
    (Icons.notifications_off_outlined, 'Avoid ringing\nbell'),
    (Icons.door_front_door_outlined, 'Leave at\nthe door'),
    (Icons.shield_outlined, 'Leave with\nsecurity'),
  ];

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
          const Text(
            'Delivery Instructions',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E221E),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: List.generate(instructions.length, (idx) {
              final isSelected = selectedInstructions.contains(idx);
              final item = instructions[idx];

              return Expanded(
                child: GestureDetector(
                  onTap: () => onToggle(idx),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: idx < instructions.length - 1 ? 10 : 0,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFF0F9F4) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF0F8A4B) : const Color(0xFFE2E4DE),
                        width: isSelected ? 1.5 : 1.1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.$1,
                          size: 22,
                          color: isSelected ? const Color(0xFF0F8A4B) : const Color(0xFF1E221E),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.$2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? const Color(0xFF0F8A4B) : const Color(0xFF4A504A),
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
