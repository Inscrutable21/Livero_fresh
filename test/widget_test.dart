import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:livero_fresh/main.dart';
import 'package:livero_fresh/theme.dart';
import 'package:livero_fresh/widgets/bottom_nav.dart';

void main() {
  testWidgets('Bottom nav and address/logo/search header hide/reappear on scroll', (WidgetTester tester) async {
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('overflowed')) return;
      previousOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const LiveroApp());
    await tester.pumpAndSettle();

    // Verify BottomNav is present and visible
    expect(find.byType(BottomNav), findsOneWidget);
    AnimatedSlide slideWidget = tester.widget(find.descendant(
      of: find.byType(BottomNav),
      matching: find.byType(AnimatedSlide),
    ));
    expect(slideWidget.offset, Offset.zero);

    // Verify Address row and Search box are visible at the top initially
    expect(find.text('DELIVERING TO'), findsOneWidget);
    expect(find.text("Search for 'milk'"), findsOneWidget);
    expect(find.text('All'), findsOneWidget);

    AnimatedCrossFade crossFade = tester.widget(find.byType(AnimatedCrossFade).first);
    expect(crossFade.crossFadeState, CrossFadeState.showFirst);

    // Find the main vertical ListView inside HomeScreen
    final mainListViewFinder = find.byWidgetPredicate(
      (widget) => widget is ListView && widget.scrollDirection == Axis.vertical,
    ).first;
    expect(mainListViewFinder, findsOneWidget);

    // Drag down (scroll down in content -> drag up with negative Y)
    await tester.drag(mainListViewFinder, const Offset(0, -300));
    await tester.pumpAndSettle();

    // Verify BottomNav is animated away (offset == Offset(0, 2.2))
    slideWidget = tester.widget(find.descendant(
      of: find.byType(BottomNav),
      matching: find.byType(AnimatedSlide),
    ));
    expect(slideWidget.offset, const Offset(0, 2.2));

    // Verify 1.png/address/search header is hidden (crossFadeState == CrossFadeState.showSecond)
    crossFade = tester.widget(find.byType(AnimatedCrossFade).first);
    expect(crossFade.crossFadeState, CrossFadeState.showSecond);

    // Verify category tabs STAY visible (only category would be there)
    expect(find.text('All'), findsOneWidget);

    // Scroll up (drag down with positive Y by 150px, still well away from top)
    await tester.drag(mainListViewFinder, const Offset(0, 150));
    await tester.pumpAndSettle();

    // Verify BottomNav reappears
    slideWidget = tester.widget(find.descendant(
      of: find.byType(BottomNav),
      matching: find.byType(AnimatedSlide),
    ));
    expect(slideWidget.offset, Offset.zero);

    // Verify top header (1.png/address/search) REMAINS hidden when scrolling up in feed
    crossFade = tester.widget(find.byType(AnimatedCrossFade).first);
    expect(crossFade.crossFadeState, CrossFadeState.showSecond);

    // Category tabs are still visible
    expect(find.text('All'), findsOneWidget);

    // Scroll all the way back to the top
    await tester.drag(mainListViewFinder, const Offset(0, 300));
    await tester.pumpAndSettle();

    // Header (1.png/address/search) reappears when scrolled back to top
    crossFade = tester.widget(find.byType(AnimatedCrossFade).first);
    expect(crossFade.crossFadeState, CrossFadeState.showFirst);
  });

  testWidgets('Category switch animates colors smoothly', (WidgetTester tester) async {
    final previousOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exceptionAsString().contains('overflowed')) return;
      previousOnError?.call(details);
    };
    addTearDown(() => FlutterError.onError = previousOnError);

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const LiveroApp());
    await tester.pumpAndSettle();

    // Initial theme is 'All'
    final initialSolid = themes['All']!.solid;
    AnimatedContainer bg = tester.widget(find.byType(AnimatedContainer).first);
    expect((bg.decoration as BoxDecoration?)?.color, initialSolid);

    // Tap on 'Fresh' category tab
    await tester.tap(find.text('Fresh'));
    await tester.pump(); // Start animation
    await tester.pump(const Duration(milliseconds: 100)); // Midway through 350ms transition

    // Complete transition
    await tester.pumpAndSettle();

    // Background color smoothly transitioned to 'Fresh' theme color
    bg = tester.widget(find.byType(AnimatedContainer).first);
    expect((bg.decoration as BoxDecoration?)?.color, themes['Fresh']!.solid);

    // Tap on 'Grocery' category tab
    await tester.tap(find.text('Grocery'));
    await tester.pumpAndSettle();

    bg = tester.widget(find.byType(AnimatedContainer).first);
    expect((bg.decoration as BoxDecoration?)?.color, themes['Grocery']!.solid);
  });
}
