import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/category_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/account_screen.dart';
import 'screens/reorder_screen.dart';

void main() => runApp(const LiveroApp());

class LiveroApp extends StatelessWidget {
  const LiveroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Livero Fresh',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: const Color(0xFFEDECE7),
          useMaterial3: true,
        ),
        home: const RootShell(),
      ),
    );
  }
}

class RootShell extends StatelessWidget {
  const RootShell({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    Widget body;
    switch (app.screen) {
      case Screen.home:
        body = const HomeScreen();
        break;
      case Screen.list:
        body = const CategoryScreen();
        break;
      case Screen.pdp:
        body = const ProductDetailScreen();
        break;
      case Screen.account:
        body = const AccountScreen();
        break;
      case Screen.reorder:
        body = const ReorderScreen();
        break;
    }
    return Scaffold(body: SafeArea(top: false, bottom: false, child: body));
  }
}

