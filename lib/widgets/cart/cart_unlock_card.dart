import 'package:flutter/material.dart';

class CartUnlockDealCard extends StatelessWidget {
  final String header;
  final String title;
  final String unit;
  final String price;
  final String mrp;
  final String subtext;
  final double progress;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool isFree;

  const CartUnlockDealCard({
    super.key,
    required this.header,
    required this.title,
    required this.unit,
    required this.price,
    required this.mrp,
    required this.subtext,
    required this.progress,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.isFree = false,
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
          // Header Tag
          Text(
            header,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F5A38),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Product Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image / Thumbnail
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: iconColor, size: 30),
              ),
              const SizedBox(width: 14),

              // Title & Unit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E221E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF757A75),
                      ),
                    ),
                  ],
                ),
              ),

              // Price Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    mrp,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E948F),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F8A4B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Subtext
          Text(
            subtext,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2C322C),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF0F5A38)),
            ),
          ),
        ],
      ),
    );
  }
}
