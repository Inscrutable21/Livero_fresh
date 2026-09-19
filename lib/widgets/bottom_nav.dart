import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final isVisible = context.select<AppState, bool>((s) => s.navVisible);
    final accent = context.select<AppState, Color>((s) => s.accent);
    final currentScreen = context.select<AppState, Screen>((s) => s.screen);
    final cartCount = context.select<AppState, int>((s) => s.cartCount);
    final app = context.read<AppState>();
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnimatedSlide(
      offset: isVisible ? Offset.zero : const Offset(0, 2.2),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        child: IgnorePointer(
          ignoring: !isVisible,
          child: Container(
            margin: EdgeInsets.fromLTRB(12, 10, 12, bottomInset > 0 ? bottomInset + 8 : 20),
            height: 64,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22), boxShadow: const [BoxShadow(color: Color(0x24122612), blurRadius: 22, offset: Offset(0, 6))]),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              _navItem(context, 'Today', Icons.grid_view_rounded, currentScreen == Screen.home, accent, () => app.setScreen(Screen.home)),
              _navItem(context, 'Aisles', Icons.apps_rounded, currentScreen == Screen.list, accent, () => app.setScreen(Screen.list)),
              _finds(context),
              _navItem(context, 'Reorder', Icons.shopping_bag_outlined, false, accent, () {}, badge: cartCount > 0 ? cartCount : null),
              _navItem(context, 'Profile', Icons.person_outline_rounded, currentScreen == Screen.account, accent, () => app.setScreen(Screen.account)),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _finds(BuildContext context) => Expanded(
    child: GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 84, height: 88, margin: const EdgeInsets.only(bottom: 0),
          transform: Matrix4.translationValues(0, -26, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [BoxShadow(color: Color(0x38122612), blurRadius: 20, offset: Offset(0, 8))],
            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF8FCBEA), Color(0xFFCDE9F2), Color(0xFFBFE0A8), Color(0xFF7FB25C)], stops: [0, 0.38, 0.55, 1]),
          ),
          child: Stack(alignment: Alignment.center, children: [
            Positioned(top: 12, child: Container(width: 26, height: 22, decoration: BoxDecoration(color: Colors.white.withOpacity(.92), borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.play_arrow, size: 14, color: Color(0xFF2A5AAE)))),
            Positioned(bottom: 8, child: Text('Finds', style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white, shadows: [Shadow(color: Colors.black.withOpacity(.25), blurRadius: 4, offset: const Offset(0, 1))]))),
          ]),
        ),
      ),
    ),
  );

  Widget _navItem(BuildContext context, String label, IconData icon, bool on, Color accent, VoidCallback onTap, {int? badge}) {
    final app = context.read<AppState>();
    final col = on ? accent : const Color(0x9912261C);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Stack(clipBehavior: Clip.none, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOutCubic,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: on ? 7 : 0),
                decoration: BoxDecoration(color: on ? app.theme.tint : Colors.transparent, borderRadius: BorderRadius.circular(100)),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TweenAnimationBuilder<Color?>(
                    tween: ColorTween(end: col),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    builder: (_, color, __) => Icon(icon, size: 20, color: color),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    style: TextStyle(fontSize: 10, color: col, fontWeight: on ? FontWeight.w600 : FontWeight.w400),
                    child: Text(label),
                  ),
                ]),
              ),
              if (badge != null)
                Positioned(top: -4, right: 6, child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4), height: 16, constraints: const BoxConstraints(minWidth: 16),
                  decoration: BoxDecoration(color: const Color(0xFFD8471F), borderRadius: BorderRadius.circular(100)),
                  alignment: Alignment.center,
                  child: Text(badge.toString(), style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.w600)),
                )),
            ]),
          ),
        ),
      ),
    );
  }
}

class BottomNavScrollListener extends StatelessWidget {
  final Widget child;
  const BottomNavScrollListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final app = context.read<AppState>();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.axis != Axis.vertical) return false;


        // Guarantee visibility when at or pulled beyond the top
        if (notification.metrics.pixels <= 0) {
          app.setNavVisible(true);
          return false;
        }

        if (notification is UserScrollNotification) {
          if (notification.direction == ScrollDirection.reverse && notification.metrics.pixels > 20) {
            app.setNavVisible(false);
          } else if (notification.direction == ScrollDirection.forward) {
            app.setNavVisible(true);
          }
        } else if (notification is ScrollUpdateNotification) {
          final delta = notification.scrollDelta ?? 0;
          if (delta > 4 && notification.metrics.pixels > 20) {
            app.setNavVisible(false);
          } else if (delta < -4) {
            app.setNavVisible(true);
          }
        }
        return false;
      },
      child: child,
    );
  }
}
