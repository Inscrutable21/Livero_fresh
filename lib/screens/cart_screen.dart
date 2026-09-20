import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../state/app_state.dart';
import '../widgets/location_sheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _lastMinuteTab = 0; // 0: Sweet Treats, 1: Fruits & Veggies, 2: Snacks
  final Set<int> _selectedInstructions = {};
  int _walletBalance = 0;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _billKey = GlobalKey();

  final List<String> _tabs = ['Sweet Treats', 'Fruits & Veggies', 'Snacks'];

  // Last minute additions mock data per tab
  final Map<int, List<_LastMinuteItem>> _lastMinuteItems = {
    0: [
      _LastMinuteItem(
        id: 'taali',
        brand: 'TAALI',
        name: 'Digestive High Fibre Biscuits',
        unit: '100 g',
        price: 29,
        mrp: 35,
        bgColor: const Color(0xFFE8DEF8),
        icon: Icons.cookie_outlined,
      ),
      _LastMinuteItem(
        id: 'motichur',
        brand: 'SANGAM',
        name: 'Motichur Laddu',
        unit: '200 g',
        price: 114,
        mrp: 180,
        bgColor: const Color(0xFFFFF3D6),
        icon: Icons.cake_outlined,
      ),
      _LastMinuteItem(
        id: 'chocolate',
        brand: 'MMMELT',
        name: 'Rum & Raisins 55% Dark',
        unit: '30 g',
        price: 59,
        mrp: 89,
        bgColor: const Color(0xFFECE0D8),
        icon: Icons.takeout_dining_outlined,
      ),
    ],
    1: [
      _LastMinuteItem(
        id: 'banana',
        brand: 'LIVERO FRESH',
        name: 'Robusta Banana',
        unit: '6 pcs',
        price: 44,
        mrp: 58,
        bgColor: const Color(0xFFFFF9DB),
        icon: Icons.eco_outlined,
      ),
      _LastMinuteItem(
        id: 'spinach',
        brand: 'ORGANIC FARMS',
        name: 'Palak — Bunch',
        unit: '250 g',
        price: 18,
        mrp: 30,
        bgColor: const Color(0xFFE8F5E9),
        icon: Icons.grass_outlined,
      ),
      _LastMinuteItem(
        id: 'tomato',
        brand: 'LOCAL HARVEST',
        name: 'Tomato — Local',
        unit: '500 g',
        price: 16,
        mrp: 42,
        bgColor: const Color(0xFFFFEBEE),
        icon: Icons.circle_outlined,
      ),
    ],
    2: [
      _LastMinuteItem(
        id: 'bread',
        brand: 'BRITANNIA',
        name: 'Whole Wheat Bread',
        unit: '400 g',
        price: 45,
        mrp: 55,
        bgColor: const Color(0xFFFFF3E0),
        icon: Icons.bakery_dining_outlined,
      ),
      _LastMinuteItem(
        id: 'potato',
        brand: 'FARMS BEST',
        name: 'Potato — New Crop',
        unit: '1 kg',
        price: 10,
        mrp: 27,
        bgColor: const Color(0xFFF5F0E4),
        icon: Icons.grain_outlined,
      ),
      _LastMinuteItem(
        id: 'carrot',
        brand: 'OOTY SPECIAL',
        name: 'Carrot — Ooty Sweet',
        unit: '500 g',
        price: 20,
        mrp: 48,
        bgColor: const Color(0xFFFFEEDB),
        icon: Icons.eco,
      ),
    ],
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBill() {
    final ctx = _billKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _addBalance() {
    setState(() {
      _walletBalance += 500;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('₹500 added! Current Wallet Balance: ₹$_walletBalance'),
        backgroundColor: const Color(0xFF0F5A38),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();

    final cartEntries = app.cart.entries.toList();
    final cartTotal = app.cartTotal;
    final cartSaved = app.cartSaved;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    // Fees calculation
    final deliveryFee = cartTotal >= 399 ? 0 : 9;
    const deliveryMrp = 29;
    const handlingFee = 12;
    const handlingMrp = 15;
    final grandTotal = cartTotal + deliveryFee + handlingFee;
    final totalSavings = cartSaved + (deliveryMrp - deliveryFee) + (handlingMrp - handlingFee);

    // Free gift & special price progress
    const specialPriceThreshold = 699;
    final awayFromSpecial = (specialPriceThreshold - cartTotal).clamp(0, specialPriceThreshold);
    final specialProgress = (cartTotal / specialPriceThreshold).clamp(0.04, 1.0);

    const giftThreshold = 499;
    final awayFromGift = (giftThreshold - cartTotal).clamp(0, giftThreshold);
    final giftProgress = (cartTotal / giftThreshold).clamp(0.04, 1.0);

    // Free delivery progress
    const freeDeliveryThreshold = 340;
    final awayFromFreeDelivery = (freeDeliveryThreshold - cartTotal).clamp(0, freeDeliveryThreshold);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF7F2),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E221E), size: 24),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Your Cart',
          style: GoogleFonts.playfairDisplay(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E241E),
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: Stack(
        children: [
          // Scrollable Content
          Positioned.fill(
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 150 + bottomInset),
              children: [
                // Top Free Delivery Banner matching screenshot
                Container(
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
                ),
                const SizedBox(height: 12),

                // 1. Unlock Special Price Deal Card
                _buildUnlockDealCard(
                  header: 'UNLOCK SPECIAL PRICE DEAL ABOVE 699',
                  title: 'Members pick Jumbo Blueberry',
                  unit: '125 g',
                  price: '₹199',
                  mrp: '₹261',
                  subtext: awayFromSpecial > 0
                      ? 'Add items worth Rs.$awayFromSpecial more to unlock'
                      : 'Special deal unlocked! Claim now',
                  progress: specialProgress,
                  icon: Icons.bubble_chart,
                  iconBg: const Color(0xFFF0E5F5),
                  iconColor: const Color(0xFF3F51B5),
                ),
                const SizedBox(height: 12),

                // 2. Free Gift on First Order Card
                _buildUnlockDealCard(
                  header: 'FREE GIFT ON FIRST ORDER ABOVE 499',
                  title: 'Royal Duo',
                  unit: 'Pomegranate (1 pc) +\nApple (1 pc)',
                  price: 'Free',
                  mrp: '₹225',
                  subtext: awayFromGift > 0
                      ? 'Add items worth Rs.$awayFromGift more to unlock'
                      : 'Free gift unlocked! Added to your order',
                  progress: giftProgress,
                  icon: Icons.apple,
                  iconBg: const Color(0xFFFDECE8),
                  iconColor: const Color(0xFFE53935),
                  isFree: true,
                ),
                const SizedBox(height: 14),

                // 3. Deals of the Day
                _buildDealsOfTheDayCard(app),
                const SizedBox(height: 14),

                // 4. Review items
                _buildReviewItemsCard(context, app, cartEntries),
                const SizedBox(height: 12),

                // 5. Missed something? Add more items
                _buildMissedSomethingCard(context),
                const SizedBox(height: 12),

                // 6. Coupon Card
                _buildCouponCard(context),
                const SizedBox(height: 14),

                // 7. Last minute additions
                _buildLastMinuteAdditionsCard(app),
                const SizedBox(height: 14),

                // 8. Your Bill
                KeyedSubtree(
                  key: _billKey,
                  child: _buildBillCard(
                    cartTotal: cartTotal,
                    cartSaved: cartSaved,
                    deliveryFee: deliveryFee,
                    deliveryMrp: deliveryMrp,
                    handlingFee: handlingFee,
                    handlingMrp: handlingMrp,
                    grandTotal: grandTotal,
                    totalSavings: totalSavings,
                    awayFromFreeDelivery: awayFromFreeDelivery,
                  ),
                ),
                const SizedBox(height: 14),

                // 9. Delivery Instructions
                _buildDeliveryInstructionsCard(),
              ],
            ),
          ),

          // 10. Sticky Bottom Bar (FirstClub Wallet + Bill Total & Add Address)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
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
                  // FirstClub Wallet Strip
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
                                text: '₹$_walletBalance',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F8A4B),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _addBalance,
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
                  const SizedBox(height: 12),

                  // Bottom Action Row: ₹GrandTotal / View Bill & Add Address
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
                            onTap: _scrollToBill,
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

                      // Add Address Button
                      SizedBox(
                        width: 195,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => showLocationSheet(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF08482A),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Add Address',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  // 1 & 2. Unlock Deal Card
  Widget _buildUnlockDealCard({
    required String header,
    required String title,
    required String unit,
    required String price,
    required String mrp,
    required String subtext,
    required double progress,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    bool isFree = false,
  }) {
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
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isFree ? const Color(0xFF0F8A4B) : const Color(0xFF0F8A4B),
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

  // 3. Deals of the day Card
  Widget _buildDealsOfTheDayCard(AppState app) {
    final deals = [
      _DealItem(
        id: 'ghee_a2',
        name: 'GoSwasthya A2 Cow Ghee',
        unit: '150 ml',
        price: 99,
        mrp: 399,
        targetAmount: 2428,
        color: const Color(0xFFFFF9E6),
        icon: Icons.local_drink,
        badge: null,
      ),
      _DealItem(
        id: 'incense',
        name: 'Art of Puja Rainforest Incense...',
        unit: '10 Sticks',
        price: 59,
        mrp: 109,
        targetAmount: 428,
        color: const Color(0xFFE8F5E9),
        icon: Icons.spa,
        badge: 'Only 2 left!',
      ),
      _DealItem(
        id: 'tea',
        name: 'Tata Premium Leaf Gold Tea',
        unit: '500 g',
        price: 189,
        mrp: 270,
        targetAmount: 650,
        color: const Color(0xFFFBE9E7),
        icon: Icons.emoji_food_beverage,
        badge: null,
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Deals of the day',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E221E),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.verified, size: 16, color: Color(0xFF2A85FF)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF3F779E), width: 1.1),
                  ),
                  child: const Text(
                    '0 of 3 deals unlocked',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF21567C),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal Deals List
          SizedBox(
            height: 200,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: deals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, i) {
                final deal = deals[i];
                return Container(
                  width: 154,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEDE9E0), width: 1.1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image Area
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              color: deal.color,
                              alignment: Alignment.center,
                              child: Icon(deal.icon, size: 36, color: Colors.black38),
                            ),
                            if (deal.badge != null)
                              Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A85FF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    deal.badge!,
                                    style: const TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Item Details
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deal.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E221E),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              deal.unit,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF757A75),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F1FB),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '₹${deal.price}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1B65A8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '₹${deal.mrp}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF8E948F),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: const Color(0xFFC7CBD1)),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.lock_outline, size: 14, color: Color(0xFF6B7280)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Bottom "Shop for ₹... more" bar
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        color: const Color(0xFFEAF2FB),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock, size: 10, color: Color(0xFF1E64A5)),
                            const SizedBox(width: 4),
                            Text(
                              'Shop for ₹${deal.targetAmount} more',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E64A5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 4. Review items Card
  Widget _buildReviewItemsCard(BuildContext context, AppState app, List<MapEntry<String, int>> cartEntries) {
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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Review items',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E221E),
                ),
              ),
              Text(
                '${cartEntries.length} ${cartEntries.length == 1 ? 'item' : 'items'}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF757A75),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (cartEntries.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.shopping_basket_outlined, size: 40, color: Color(0xFFB0B5B0)),
                    const SizedBox(height: 8),
                    const Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E221E)),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Add items from below or browse more',
                      style: TextStyle(fontSize: 12, color: Color(0xFF757A75)),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cartEntries.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFF0EBE1)),
              ),
              itemBuilder: (ctx, i) {
                final entry = cartEntries[i];
                final key = entry.key;
                final qty = entry.value;

                final sep = key.indexOf('::');
                final pidPart = sep < 0 ? key : key.substring(0, sep);
                final vIdx = sep < 0 ? null : int.parse(key.substring(sep + 2));
                final p = byId(pidPart);
                final v = (vIdx != null && p.variants != null) ? p.variants![vIdx] : null;

                final label = v != null ? '${v.label} x $qty' : '${p.unit} x $qty';
                final price = v != null ? v.price : p.price;
                final mrp = v != null ? v.mrp : p.mrp;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Product image container
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: p.color,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE8E5DD)),
                      ),
                      alignment: Alignment.center,
                      child: Icon(p.icon, size: 26, color: Colors.black45),
                    ),
                    const SizedBox(width: 12),

                    // Title & Unit
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E221E),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757A75),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stepper & Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Stepper Pill
                        Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFDCDFD8), width: 1.1),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => app.bump(key, -1),
                                borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Icon(Icons.remove, size: 15, color: Color(0xFF1E221E)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  '$qty',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E221E),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => app.bump(key, 1),
                                borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Icon(Icons.add, size: 15, color: Color(0xFF1E221E)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Price Row
                        Row(
                          children: [
                            Text(
                              '₹${mrp * qty}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8E948F),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '₹${price * qty}',
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
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  // 5. Missed something? Add more items
  Widget _buildMissedSomethingCard(BuildContext context) {
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
            onTap: () => Navigator.maybePop(context),
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

  // 6. Coupon Card
  Widget _buildCouponCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFEAD0), width: 1.2),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFDF8), Color(0xFFFFF4E6)],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Discount Icon
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFDE8D1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.percent, size: 18, color: Color(0xFF9E6320)),
                ),
                const SizedBox(width: 12),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Get 10% OFF with "CLEAN10"',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E221E),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Add Cleaning Essentials products worth Rs.299.0 to apply.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF6B726B),
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                // Add Items Button
                InkWell(
                  onTap: () => Navigator.maybePop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF1E221E), width: 1.2),
                    ),
                    child: const Text(
                      'Add Items',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E221E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF3E4D3)),

          // View all coupons
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Coupon CLEAN10 copied!'),
                  backgroundColor: const Color(0xFF0F5A38),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'View all coupons',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E221E),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: Color(0xFF1E221E)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 7. Last minute additions Card
  Widget _buildLastMinuteAdditionsCard(AppState app) {
    final currentItems = _lastMinuteItems[_lastMinuteTab] ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE9E0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Last minute additions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E221E),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Tabs Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(_tabs.length, (idx) {
                final isSelected = _lastMinuteTab == idx;
                return GestureDetector(
                  onTap: () => setState(() => _lastMinuteTab = idx),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    padding: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isSelected ? const Color(0xFF1E221E) : Colors.transparent,
                          width: 2.2,
                        ),
                      ),
                    ),
                    child: Text(
                      _tabs[idx],
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? const Color(0xFF1E221E) : const Color(0xFF8E948F),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),

          // Horizontal Products List
          SizedBox(
            height: 196,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: currentItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (ctx, i) {
                final item = currentItems[i];
                return Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEDE9E0), width: 1.1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image with floating Add (+) button
                      SizedBox(
                        height: 94,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 94,
                              color: item.bgColor,
                              alignment: Alignment.center,
                              child: Icon(item.icon, size: 38, color: Colors.black45),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: GestureDetector(
                                onTap: () => app.add(item.id),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x30000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.add, size: 18, color: Color(0xFF1E221E)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Item Details
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.brand,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF9E9E9E),
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E221E),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.unit,
                              style: const TextStyle(
                                fontSize: 10.5,
                                color: Color(0xFF757A75),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '₹ ${item.price}',
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1E221E),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '₹ ${item.mrp}',
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    color: Color(0xFF8E948F),
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 8. Your Bill Card
  Widget _buildBillCard({
    required int cartTotal,
    required int cartSaved,
    required int deliveryFee,
    required int deliveryMrp,
    required int handlingFee,
    required int handlingMrp,
    required int grandTotal,
    required int totalSavings,
    required int awayFromFreeDelivery,
  }) {
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

  // 9. Delivery Instructions Card
  Widget _buildDeliveryInstructionsCard() {
    final instructions = [
      (Icons.notifications_off_outlined, 'Avoid ringing\nbell'),
      (Icons.door_front_door_outlined, 'Leave at\nthe door'),
      (Icons.shield_outlined, 'Leave with\nsecurity'),
    ];

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
              final isSelected = _selectedInstructions.contains(idx);
              final item = instructions[idx];

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedInstructions.remove(idx);
                      } else {
                        _selectedInstructions.add(idx);
                      }
                    });
                  },
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

class _LastMinuteItem {
  final String id;
  final String brand;
  final String name;
  final String unit;
  final int price;
  final int mrp;
  final Color bgColor;
  final IconData icon;

  const _LastMinuteItem({
    required this.id,
    required this.brand,
    required this.name,
    required this.unit,
    required this.price,
    required this.mrp,
    required this.bgColor,
    required this.icon,
  });
}

class _DealItem {
  final String id;
  final String name;
  final String unit;
  final int price;
  final int mrp;
  final int targetAmount;
  final Color color;
  final IconData icon;
  final String? badge;

  const _DealItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.mrp,
    required this.targetAmount,
    required this.color,
    required this.icon,
    this.badge,
  });
}
