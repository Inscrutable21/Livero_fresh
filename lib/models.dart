import 'package:flutter/material.dart';

class Variant {
  final String label;
  final int price;
  final int mrp;
  const Variant(this.label, this.price, this.mrp);
}

class Product {
  final String id, name, unit, brand;
  final int price, mrp, off, eta;
  final Color color;
  final IconData icon;
  final List<Variant>? variants;
  const Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.brand,
    required this.price,
    required this.mrp,
    required this.off,
    required this.eta,
    required this.color,
    required this.icon,
    this.variants,
  });
}

final List<Product> products = [
  const Product(id: 'carrot', name: 'Carrot — Ooty', unit: '500 g', price: 20, mrp: 48, off: 58, brand: 'Livero Fresh Farms', eta: 9, color: Color(0xFFFFF1E3), icon: Icons.eco),
  const Product(id: 'ginger', name: 'Ginger', unit: '250 g', price: 25, mrp: 62, off: 60, brand: 'Livero Fresh Farms', eta: 9, color: Color(0xFFF8F1E3), icon: Icons.grass),
  const Product(id: 'potato', name: 'Potato — New', unit: '1 kg', price: 10, mrp: 27, off: 63, brand: 'Livero Fresh Farms', eta: 9, color: Color(0xFFF5F0E4), icon: Icons.circle),
  const Product(id: 'tomato', name: 'Tomato — Local', unit: '500 g', price: 16, mrp: 42, off: 62, brand: 'Livero Fresh Farms', eta: 9, color: Color(0xFFFDEDEA), icon: Icons.circle),
  const Product(id: 'onion', name: 'Onion', unit: '1 kg', price: 32, mrp: 60, off: 47, brand: 'Livero Fresh Farms', eta: 11, color: Color(0xFFF7EFF7), icon: Icons.circle),
  const Product(id: 'banana', name: 'Banana — Robusta', unit: '6 pcs', price: 44, mrp: 58, off: 24, brand: 'Livero Fresh Farms', eta: 9, color: Color(0xFFFFF8DC), icon: Icons.eco),
  const Product(id: 'spinach', name: 'Palak — Bunch', unit: '250 g', price: 18, mrp: 30, off: 40, brand: 'Livero Fresh Farms', eta: 11, color: Color(0xFFEDF7EC), icon: Icons.eco),
  const Product(id: 'capsicum', name: 'Capsicum — Green', unit: '250 g', price: 24, mrp: 45, off: 46, brand: 'Livero Fresh Farms', eta: 9, color: Color(0xFFEEF6EA), icon: Icons.eco),
  const Product(id: 'atta', name: 'Aashirvaad Atta', unit: '5 kg', price: 279, mrp: 340, off: 18, brand: 'Aashirvaad', eta: 12, color: Color(0xFFF4E8D7), icon: Icons.grain, variants: [Variant('10 kg', 520, 680), Variant('5 kg', 279, 340)]),
  const Product(id: 'oil', name: 'Sunlite Refined Oil', unit: '1 L', price: 145, mrp: 190, off: 24, brand: 'Fortune', eta: 12, color: Color(0xFFFFF5DA), icon: Icons.opacity, variants: [Variant('2 L', 270, 380), Variant('1 L', 145, 190)]),
  const Product(id: 'tea', name: 'Premium Leaf Tea', unit: '1 kg', price: 520, mrp: 610, off: 15, brand: 'Tata Tea', eta: 12, color: Color(0xFFF7E4DA), icon: Icons.emoji_food_beverage, variants: [Variant('1.5 kg', 730, 915), Variant('1 kg', 520, 610)]),
  const Product(id: 'milk', name: 'Toned Milk', unit: '500 ml', price: 28, mrp: 32, off: 12, brand: 'Amul', eta: 9, color: Color(0xFFEBF3FF), icon: Icons.local_drink),
  const Product(id: 'detergent', name: 'Matic Top Load Liquid', unit: '1 kg', price: 132, mrp: 160, off: 18, brand: 'Surf Excel', eta: 14, color: Color(0xFFE7F0FA), icon: Icons.local_laundry_service, variants: [Variant('2 kg', 245, 320), Variant('1 kg', 132, 160)]),
  const Product(id: 'cream', name: 'Beauty Cream', unit: '200 ml', price: 210, mrp: 260, off: 19, brand: 'Dove', eta: 14, color: Color(0xFFF4EFF8), icon: Icons.spa),
  const Product(id: 'bread', name: 'Whole Wheat Bread', unit: '400 g', price: 45, mrp: 55, off: 18, brand: 'Britannia', eta: 9, color: Color(0xFFFAF0E1), icon: Icons.bakery_dining),
  const Product(id: 'rice', name: 'Sona Masoori Rice', unit: '5 kg', price: 399, mrp: 475, off: 16, brand: 'Livero Fresh Select', eta: 14, color: Color(0xFFF6F1E2), icon: Icons.rice_bowl, variants: [Variant('10 kg', 749, 950), Variant('5 kg', 399, 475)]),
  // Cart & Deals items
  const Product(id: 'batter', name: "Member's Pick Idli & Dosa Batter", unit: '750 g', price: 59, mrp: 100, off: 41, brand: "Member's Pick", eta: 9, color: Color(0xFFEFEFEF), icon: Icons.breakfast_dining),
  const Product(id: 'blueberry', name: 'Members pick Jumbo Blueberry', unit: '125 g', price: 199, mrp: 261, off: 24, brand: "Member's Pick", eta: 9, color: Color(0xFFE8EEF8), icon: Icons.bubble_chart),
  const Product(id: 'royal_duo', name: 'Royal Duo (Pomegranate + Apple)', unit: '2 pcs', price: 0, mrp: 225, off: 100, brand: 'Livero Fresh', eta: 9, color: Color(0xFFFDEDEA), icon: Icons.apple),
  const Product(id: 'taali', name: 'Digestive High Fibre Biscuits', unit: '100 g', price: 29, mrp: 35, off: 17, brand: 'TAALI', eta: 9, color: Color(0xFFF3E5F5), icon: Icons.cookie),
  const Product(id: 'motichur', name: 'Motichur Laddu', unit: '200 g', price: 114, mrp: 180, off: 37, brand: 'SANGAM', eta: 9, color: Color(0xFFFFF8E1), icon: Icons.cake),
  const Product(id: 'chocolate', name: 'Rum & Raisins 55% Dark Chocolate', unit: '30 g', price: 59, mrp: 89, off: 34, brand: 'MMMELT', eta: 9, color: Color(0xFFEFEBE9), icon: Icons.takeout_dining),
  const Product(id: 'ghee_a2', name: 'GoSwasthya A2 Cow Ghee', unit: '150 ml', price: 99, mrp: 399, off: 75, brand: 'GoSwasthya', eta: 9, color: Color(0xFFFFFDE7), icon: Icons.local_drink),
  const Product(id: 'incense', name: 'Art of Puja Rainforest Incense', unit: '10 Sticks', price: 59, mrp: 109, off: 46, brand: 'Art of Puja', eta: 9, color: Color(0xFFE0F2F1), icon: Icons.spa),
];

Product byId(String id) => products.firstWhere(
  (p) => p.id == id,
  orElse: () => Product(
    id: id,
    name: id,
    unit: '1 pc',
    price: 49,
    mrp: 60,
    off: 18,
    brand: 'Livero Fresh',
    eta: 9,
    color: const Color(0xFFF2F2F2),
    icon: Icons.shopping_basket_outlined,
  ),
);

const Map<String, List<String>> subsets = {
  'All': ['tomato', 'carrot', 'potato', 'onion', 'spinach', 'capsicum', 'banana', 'ginger'],
  'Fresh vegetables': ['tomato', 'potato', 'onion', 'capsicum', 'carrot'],
  'Fresh fruits': ['banana'],
  'Herbs & seasoning': ['ginger', 'spinach'],
  'Exotics': ['capsicum', 'banana', 'ginger'],
  'Cuts & sprouts': ['spinach', 'carrot', 'capsicum'],
  'Organics': ['spinach', 'tomato', 'carrot', 'ginger'],
};

