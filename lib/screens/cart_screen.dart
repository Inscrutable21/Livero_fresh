import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/location_sheet.dart';
import '../widgets/cart/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Set<int> _selectedInstructions = {};
  int _walletBalance = 0;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _billKey = GlobalKey();

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

  void _toggleInstruction(int idx) {
    setState(() {
      if (_selectedInstructions.contains(idx)) {
        _selectedInstructions.remove(idx);
      } else {
        _selectedInstructions.add(idx);
      }
    });
  }

  void _placeOrder() {
    final app = context.read<AppState>();
    final grandTotal = app.cartTotal + (app.cartTotal >= 399 ? 0 : 9) + 12;
    final addressLine = app.selectedAddress.line;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F6EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF0F8A4B),
                size: 44,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Order Placed!',
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E221E),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order of ₹$grandTotal has been placed successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF5F6D64),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Delivering to $addressLine in 9 mins ⚡',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F8A4B),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  app.clearCart();
                  Navigator.pop(ctx);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF08482A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
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
            color: const Color(0xFF1E221E),
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
                // 1. Top Free Delivery Banner
                CartDeliveryBanner(
                  awayFromFreeDelivery: awayFromFreeDelivery,
                  cartTotal: cartTotal,
                  freeDeliveryThreshold: freeDeliveryThreshold,
                ),
                const SizedBox(height: 12),

                // 2. Unlock Special Price Deal Card
                CartUnlockDealCard(
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

                // 3. Free Gift on First Order Card
                CartUnlockDealCard(
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

                // 4. Deals of the Day Carousel
                const CartDealsSection(),
                const SizedBox(height: 14),

                // 5. Review items
                CartReviewItems(
                  app: app,
                  cartEntries: cartEntries,
                ),
                const SizedBox(height: 12),

                // 6. Missed something? Add more items
                CartMissedSomething(
                  onAddMore: () => Navigator.maybePop(context),
                ),
                const SizedBox(height: 12),

                // 7. Coupon Card
                CartCouponCard(
                  onAddItems: () => Navigator.maybePop(context),
                ),
                const SizedBox(height: 14),

                // 8. Last minute additions
                CartLastMinuteSection(
                  onAdd: (id) => app.add(id),
                ),
                const SizedBox(height: 14),

                // 9. Your Bill
                KeyedSubtree(
                  key: _billKey,
                  child: CartBillSection(
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

                // 10. Delivery Instructions
                CartDeliveryInstructions(
                  selectedInstructions: _selectedInstructions,
                  onToggle: _toggleInstruction,
                ),
              ],
            ),
          ),

          // 11. Sticky Bottom Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CartBottomBar(
              walletBalance: _walletBalance,
              grandTotal: grandTotal,
              isAddressAdded: app.isAddressAdded,
              addressLine: app.selectedAddress.line,
              onAddBalance: _addBalance,
              onViewBill: _scrollToBill,
              onAddAddress: () => showLocationSheet(context),
              onPlaceOrder: _placeOrder,
            ),
          ),
        ],
      ),
    );
  }
}
