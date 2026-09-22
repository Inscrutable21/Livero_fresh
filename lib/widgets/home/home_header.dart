import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../state/app_state.dart';
import '../../theme.dart';
import '../location_sheet.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final CatTheme theme;
  final Color accent;
  final String selectedAddressLine;
  final String currentTab;
  final double topPadding;
  final AppState app;
  final List<List<dynamic>> tabDefs;

  HomeHeaderDelegate({
    required this.theme,
    required this.accent,
    required this.selectedAddressLine,
    required this.currentTab,
    required this.topPadding,
    required this.app,
    required this.tabDefs,
  });

  static const double _topSectionHeight = 166.0;
  static const double _tabsHeight = 78.0;
  static const double _bottomGap = 6.0;

  @override
  double get maxExtent => topPadding + _topSectionHeight + _tabsHeight + _bottomGap;

  @override
  double get minExtent => topPadding + _tabsHeight + _bottomGap;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final clampedShrink = math.max(0.0, math.min(shrinkOffset, _topSectionHeight));
    final topOpacity = (1.0 - (clampedShrink / (_topSectionHeight * 0.75))).clamp(0.0, 1.0);
    final isPinned = shrinkOffset >= _topSectionHeight;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: theme.headerGradient,
        ),
        boxShadow: isPinned || overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ClipRect(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: topPadding + 10 - clampedShrink,
              left: 16,
              right: 16,
              child: IgnorePointer(
                ignoring: topOpacity < 0.2,
                child: Opacity(
                  opacity: topOpacity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            'assests/1.png',
                            height: 40,
                            cacheHeight: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => showLocationSheet(context),
                              child: Row(
                                children: [
                                  TweenAnimationBuilder<Color?>(
                                    tween: ColorTween(end: accent),
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeInOutCubic,
                                    builder: (_, color, __) => Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: color,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DELIVERING TO',
                                          style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: .5,
                                            color: Colors.black.withValues(alpha: .55),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                selectedAddressLine,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF12261C),
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 16,
                                              color: Color(0xFF12261C),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => app.setScreen(Screen.account),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_outline,
                                size: 19,
                                color: Color(0xFF12261C),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 46,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x12122612),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.search, size: 18, color: Color(0xFF4C6157)),
                                  SizedBox(width: 9),
                                  Expanded(
                                    child: Text(
                                      "Search for 'milk'",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0x6B12261C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 9),
                          _iconBtn(Icons.receipt_long_outlined),
                          const SizedBox(width: 9),
                          _iconBtn(Icons.favorite_border),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: math.max(
                topPadding,
                topPadding + _topSectionHeight - clampedShrink,
              ),
              left: 0,
              right: 0,
              height: _tabsHeight,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: tabDefs.length,
                itemBuilder: (_, i) {
                  final name = tabDefs[i][0] as String;
                  final icon = tabDefs[i][1] as IconData;
                  final on = currentTab == name;
                  return GestureDetector(
                    onTap: () => app.setTab(name),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOutCubic,
                      width: 74,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: on ? accent : Colors.transparent,
                            width: 2.5,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                            height: 44,
                            decoration: BoxDecoration(
                              color: on ? theme.tint : Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: on
                                  ? [
                                      BoxShadow(
                                        color: accent.withValues(alpha: 0.18),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : const [],
                            ),
                            child: Center(
                              child: TweenAnimationBuilder<Color?>(
                                tween: ColorTween(
                                  end: on ? accent : const Color(0xFF4C6157),
                                ),
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeInOutCubic,
                                builder: (_, color, __) => Icon(icon, color: color),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOutCubic,
                            style: TextStyle(
                              fontSize: 12,
                              color: on ? accent : const Color(0x9912261C),
                              fontWeight: on ? FontWeight.w600 : FontWeight.w500,
                            ),
                            child: Text(name),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _iconBtn(IconData icon) => Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12122612),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF12261C)),
      );

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) {
    return oldDelegate.theme != theme ||
        oldDelegate.accent != accent ||
        oldDelegate.selectedAddressLine != selectedAddressLine ||
        oldDelegate.currentTab != currentTab ||
        oldDelegate.topPadding != topPadding;
  }
}
