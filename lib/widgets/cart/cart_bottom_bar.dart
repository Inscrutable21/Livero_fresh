import 'package:flutter/material.dart';

class CartBottomBar extends StatelessWidget {
  final int walletBalance;
  final int grandTotal;
  final bool isAddressAdded;
  final String? addressLine;
  final VoidCallback onAddBalance;
  final VoidCallback onViewBill;
  final VoidCallback onAddAddress;
  final VoidCallback? onPlaceOrder;

  const CartBottomBar({
    super.key,
    required this.walletBalance,
    required this.grandTotal,
    this.isAddressAdded = false,
    this.addressLine,
    required this.onAddBalance,
    required this.onViewBill,
    required this.onAddAddress,
    this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset > 0 ? bottomInset + 8 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF7F2),
        border: const Border(top: BorderSide(color: Color(0xFFEDE9E0), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Livero Fresh Wallet Strip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD6EAD9), width: 1.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 14.5, color: Color(0xFF1E221E)),
                    children: [
                      const TextSpan(
                        text: 'Livero Fresh Wallet: ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '₹$walletBalance',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F8A4B),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onAddBalance,
                  child: const Text(
                    'Add Balance',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F8A4B),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF0F8A4B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isAddressAdded && addressLine != null && addressLine!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFD6EAD9), width: 1.1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 15, color: Color(0xFF0F8A4B)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Deliver to: $addressLine',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E221E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: onAddAddress,
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F8A4B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),

          // Bottom Action Row: ₹GrandTotal / View Bill & Add Address / Place Order
          Row(
            children: [
              // Total & View Bill Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '₹$grandTotal',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E221E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: onViewBill,
                    child: const Text(
                      'View Bill',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F5A38),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Action Button: Add Address -> Place Order
              SizedBox(
                width: 195,
                height: 52,
                child: ElevatedButton(
                  onPressed: isAddressAdded ? onPlaceOrder : onAddAddress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAddressAdded
                        ? const Color(0xFF0F7D43)
                        : const Color(0xFF08482A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Row(
                      key: ValueKey<bool>(isAddressAdded),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isAddressAdded ? 'Place Order' : 'Add Address',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isAddressAdded) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
