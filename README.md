# Livero Fresh Grocery App (Flutter)

Flutter rebuild of the Livero Fresh 10-minute delivery prototype (Home, Categories, Product Detail, Account),
matching the HTML design's colors, layout and interactions.

## Run
```
flutter pub get
flutter run
```

## Structure
- lib/models.dart — product data
- lib/theme.dart — per-category color themes (accent/tint/gradients), mirrors the web app's THEMES map
- lib/state/app_state.dart — app state (screen nav, cart, addresses, sheets) via provider/ChangeNotifier
- lib/widgets/ — ProductCard, BottomNav, variant bottom sheet, location bottom sheet
- lib/screens/ — HomeScreen, CategoryScreen, ProductDetailScreen, AccountScreen

## Notes
- Product imagery uses colored placeholder tiles with Material icons — drop in real product photos
  (Image.asset/Image.network) inside ProductCard's image container and the PDP hero when available.
- Cart, address book and category theming are all wired end-to-end; hook up a backend by replacing
  AppState's in-memory fields with your data layer.
