import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/location_sheet.dart';
import '../widgets/view_basket_bar.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final navVisible = context.select<AppState, bool>((s) => s.navVisible);
    final cartCount = context.select<AppState, int>((s) => s.cartCount);
    final basketBottom = navVisible
        ? (bottomInset > 0 ? bottomInset + 84 : 96.0)
        : (bottomInset > 0 ? bottomInset + 12 : 16.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BottomNavScrollListener(
            child: ListView(
              padding: EdgeInsets.only(
                bottom: 110 + bottomInset + (cartCount > 0 ? 68 : 0),
              ),
              children: [
                // Top Green Header Section
                _buildHeader(context, app),
                const SizedBox(height: 18),
                // 3 Quick Action Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _actionCard(
                        icon: _groceryBagIcon(),
                        subtitle: 'No active orders',
                        subtitleColor: const Color(0x8A12261C),
                        title: 'Orders',
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _actionCard(
                        icon: _walletIcon(),
                        subtitle: '₹0',
                        subtitleColor: const Color(0xFF0E7A4B),
                        title: 'Wallet',
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _actionCard(
                        icon: _findsIcon(),
                        subtitle: '',
                        subtitleColor: Colors.transparent,
                        title: 'Finds',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                // Menu List Items
                _menuItem(
                  icon: Icons.location_on_outlined,
                  title: 'Addresses',
                  subtitle: 'Your saved delivery addresses',
                  onTap: () => showLocationSheet(context),
                ),
                _menuItem(
                  icon: Icons.headphones_outlined,
                  title: 'Help & Support',
                  subtitle: 'We’re here for you',
                  onTap: () {},
                ),
                _menuItem(
                  icon: Icons.card_giftcard_outlined,
                  title: 'Claim gift card',
                  subtitle: 'Redeem and add money to your wallet',
                  onTap: () {},
                ),
                _menuItem(
                  icon: Icons.rate_review_outlined,
                  title: 'Write to the founder',
                  subtitle: 'Tell us your thoughts',
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, indent: 18, endIndent: 18, color: Color(0x12122612)),
                const SizedBox(height: 8),
                _menuItem(
                  icon: Icons.logout_rounded,
                  title: 'Log Out',
                  subtitle: 'Switch or exit current account',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    'Livero Fresh · v1.0.0',
                    style: TextStyle(fontSize: 11, color: Color(0x5912261C)),
                  ),
                ),
              ],
            ),
          ),
          ViewBasketBar(bottom: basketBottom),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppState app) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F5A38),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
              child: CustomPaint(painter: _FloralPatternPainter()),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, topPadding + 10, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                GestureDetector(
                  onTap: () => app.setScreen(Screen.home),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                // Heading: Yours
                Text(
                  'Yours',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                // Subtitle: Edit profile >
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Edit profile',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                // Dark Card: Tell us more about yourself
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF073822),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tell us more about yourself',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {},
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Complete Profile',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      _notepadIllustration(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _notepadIllustration() {
    return SizedBox(
      width: 78,
      height: 72,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Back layer
          Positioned(
            top: 6,
            left: 10,
            child: Container(
              width: 52,
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFE5D5BA),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Main notepad
          Positioned(
            top: 2,
            left: 12,
            child: Container(
              width: 52,
              height: 60,
              padding: const EdgeInsets.fromLTRB(7, 10, 7, 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F2DE),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 2.5, width: 30, decoration: BoxDecoration(color: const Color(0xFFDAC7A5), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 5),
                  Container(height: 2.5, width: 36, decoration: BoxDecoration(color: const Color(0xFFDAC7A5), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 5),
                  Container(height: 2.5, width: 22, decoration: BoxDecoration(color: const Color(0xFFDAC7A5), borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 5),
                  Container(height: 2.5, width: 32, decoration: BoxDecoration(color: const Color(0xFFDAC7A5), borderRadius: BorderRadius.circular(2))),
                ],
              ),
            ),
          ),
          // Spiral Rings
          Positioned(
            top: 0,
            left: 16,
            child: Row(
              children: List.generate(
                4,
                (i) => Container(
                  margin: const EdgeInsets.only(right: 5),
                  width: 5,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37),
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: const Color(0xFF8B6712), width: 0.6),
                  ),
                ),
              ),
            ),
          ),
          // Angled 3D Pencil
          Positioned(
            bottom: 2,
            left: 0,
            child: Transform.rotate(
              angle: -0.65,
              child: Container(
                width: 12,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8BB55D), Color(0xFF6B993D)],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 4,
                      offset: Offset(1, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Pink Eraser
                    Container(
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE88E8E),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                      ),
                    ),
                    // Gold ferrule
                    Container(height: 2.5, color: const Color(0xFFD4AF37)),
                    const Spacer(),
                    // Wood tip
                    ClipPath(
                      clipper: _PencilTipClipper(),
                      child: Container(
                        height: 10,
                        width: 12,
                        color: const Color(0xFFE6C898),
                        alignment: Alignment.bottomCenter,
                        child: Container(height: 3, width: 3, color: const Color(0xFF2C2C2C)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _groceryBagIcon() {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Carrot & bread peeking out
          Positioned(
            top: 2,
            left: 12,
            child: Transform.rotate(
              angle: -0.22,
              child: Container(
                width: 7,
                height: 17,
                decoration: BoxDecoration(
                  color: const Color(0xFFE87A1E),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 13,
            child: Container(
              width: 13,
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xFF43A047),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          // Green Bag
          Positioned(
            bottom: 2,
            child: Container(
              width: 32,
              height: 29,
              decoration: BoxDecoration(
                color: const Color(0xFF386641),
                borderRadius: BorderRadius.circular(7),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.star, size: 10, color: Color(0xFFFFE082)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _walletIcon() {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Currency notes
          Positioned(
            top: 4,
            left: 12,
            child: Transform.rotate(
              angle: -0.15,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: const Color(0xFF81C784),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          Positioned(
            top: 3,
            right: 12,
            child: Transform.rotate(
              angle: 0.12,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: const Color(0xFFA5D6A7),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          // Green Wallet
          Positioned(
            bottom: 3,
            child: Container(
              width: 34,
              height: 26,
              decoration: BoxDecoration(
                color: const Color(0xFF386641),
                borderRadius: BorderRadius.circular(7),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.star, size: 10, color: Color(0xFFFFE082)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _findsIcon() {
    return SizedBox(
      width: 44,
      height: 44,
      child: Center(
        child: Container(
          width: 24,
          height: 33,
          decoration: const BoxDecoration(
            color: Color(0xFF386641),
            borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Color(0x20000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 6),
              const Icon(Icons.star, size: 11, color: Color(0xFFFFE082)),
              const Spacer(),
              ClipPath(
                clipper: _RibbonNotchClipper(),
                child: Container(height: 7, color: const Color(0xFFF7ECE0)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _actionCard({
    required Widget icon,
    required String subtitle,
    required Color subtitleColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 122,
          padding: const EdgeInsets.fromLTRB(8, 14, 8, 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7ECE0),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              SizedBox(height: 42, child: icon),
              const SizedBox(height: 6),
              SizedBox(
                height: 14,
                child: subtitle.isNotEmpty
                    ? Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: subtitle == '₹0' ? FontWeight.w700 : FontWeight.w500,
                          color: subtitleColor,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF12261C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 24, color: const Color(0xFF12261C)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF12261C),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0x7312261C),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 22,
              color: Color(0xFF12261C),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloralPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    // Center flower
    final center = Offset(size.width * 0.75, size.height * 0.32);
    for (int i = 0; i < 8; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * 3.14159 / 4);
      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(28, -22, 68, 0)
        ..quadraticBezierTo(28, 22, 0, 0);
      canvas.drawPath(path, paint);
      canvas.restore();
    }

    // Secondary shapes on right
    final center2 = Offset(size.width * 0.95, size.height * 0.72);
    for (int i = 0; i < 6; i++) {
      canvas.save();
      canvas.translate(center2.dx, center2.dy);
      canvas.rotate(i * 3.14159 / 3);
      final path2 = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(22, -18, 52, 0)
        ..quadraticBezierTo(22, 18, 0, 0);
      canvas.drawPath(path2, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PencilTipClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _RibbonNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
