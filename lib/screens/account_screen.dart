import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/location_sheet.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    return Container(
      color: const Color(0xFFF7F8F5),
      child: Column(children: [
        SafeArea(bottom: false, child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0x12122612), blurRadius: 0, offset: Offset(0, 1))]),
          child: Row(children: [
            GestureDetector(onTap: () => app.setScreen(Screen.home), child: Container(width: 34, height: 34, decoration: BoxDecoration(color: const Color(0xFFF2F4F1), borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Color(0xFF12261C)))),
            const SizedBox(width: 10),
            const Text('My Account', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
          ]),
        )),
        Expanded(
          child: Stack(
            children: [
              BottomNavScrollListener(
                child: ListView(padding: EdgeInsets.fromLTRB(14, 16, 14, 104 + MediaQuery.paddingOf(context).bottom), children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0D122612), blurRadius: 8, offset: Offset(0, 2))]), child: Row(children: [
            Container(width: 54, height: 54, decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [app.accent, const Color(0xFF0A5C39)])), alignment: Alignment.center, child: const Text('RM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Rahul Mehta', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
              const SizedBox(height: 3),
              const Text('+91 98765 43210', style: TextStyle(fontSize: 12, color: Color(0x8012261C))),
            ])),
            Container(width: 36, height: 36, decoration: const BoxDecoration(color: Color(0xFFF2F4F1), shape: BoxShape.circle), child: const Icon(Icons.edit_outlined, size: 15, color: Color(0xFF12261C))),
          ])),
          const SizedBox(height: 16),
          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [const Color(0xFF123D2B), app.accent]), boxShadow: const [BoxShadow(color: Color(0x28122612), blurRadius: 16, offset: Offset(0, 6))]), child: Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.white.withOpacity(.16), borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.stars, color: Color(0xFFFFE9A8))),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Livero Fresh Xtra', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
              SizedBox(height: 2),
              Text('Free delivery + extra rewards on every order', style: TextStyle(fontSize: 10.5, color: Color(0xBFFFFFFF))),
            ])),
            const Icon(Icons.chevron_right, size: 16, color: Colors.white),
          ])),
          const SizedBox(height: 16),
          Padding(padding: const EdgeInsets.fromLTRB(4, 0, 4, 8), child: Text('YOUR INFORMATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .6, color: Colors.black.withOpacity(.45)))),
          Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0D122612), blurRadius: 8, offset: Offset(0, 2))]), clipBehavior: Clip.antiAlias, child: Column(children: [
            _row(Icons.receipt_long_outlined, const Color(0xFFEAF6EF), const Color(0xFF0E7A4B), 'Your Orders', 'Track, reorder, view invoices', () {}),
            _row(Icons.location_on_outlined, const Color(0xFFEDF3FC), const Color(0xFF2A5AAE), 'Saved Addresses', app.allAddresses.length.toString() + ' addresses saved', () => showLocationSheet(context)),
            _row(Icons.credit_card, const Color(0xFFFBF2E4), const Color(0xFFB4762C), 'Payment Methods', 'Cards, UPI & wallets', () {}),
            _row(Icons.shield_outlined, const Color(0xFFF1ECFA), const Color(0xFF6E4FA8), 'Account Privacy', null, () {}, last: true),
          ])),
          const SizedBox(height: 16),
          Padding(padding: const EdgeInsets.fromLTRB(4, 0, 4, 8), child: Text('SUPPORT & MORE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .6, color: Colors.black.withOpacity(.45)))),
          Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0D122612), blurRadius: 8, offset: Offset(0, 2))]), clipBehavior: Clip.antiAlias, child: Column(children: [
            _row(Icons.help_outline, const Color(0xFFEAF6F9), const Color(0xFF2A8FA6), 'Help Centre', null, () {}),
            _row(Icons.notifications_none, const Color(0xFFFBEEEA), const Color(0xFFC2542B), 'Notification Preferences', null, () {}),
            _row(Icons.description_outlined, const Color(0xFFF2F4F1), const Color(0xFF12261C), 'Terms & Conditions', null, () {}),
            _row(Icons.logout, const Color(0xFFFBEAE6), const Color(0xFFC2401F), 'Log Out', null, () {}, last: true, danger: true),
          ])),
          const SizedBox(height: 14),
          const Text('Livero Fresh · v1.0.0', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, color: Color(0x5912261C))),
                ]),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: BottomNav(),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _row(IconData icon, Color bg, Color fg, String title, String? subtitle, VoidCallback onTap, {bool last = false, bool danger = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: Color(0x0F122612)))),
        child: Row(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, size: 17, color: fg)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: danger ? const Color(0xFFC2401F) : const Color(0xFF12261C))),
            if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(subtitle, style: const TextStyle(fontSize: 10.5, color: Color(0x7312261C)))),
          ])),
          if (!danger) const Icon(Icons.chevron_right, size: 15, color: Color(0x59122612)),
        ]),
      ),
    );
  }
}
