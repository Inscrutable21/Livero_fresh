import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';

enum Screen { home, list, pdp, account, reorder }


class Address {
  final String id;
  final String tag, line, sub;
  Address({required this.id, required this.tag, required this.line, required this.sub});
}

class AppState extends ChangeNotifier {
  Screen screen = Screen.home;
  String tab = 'All';
  Map<String, int> cart = {'carrot': 2, 'milk': 1};
  String cat = 'Fruits & Veggies';
  String sub = 'All';
  String filter = 'Sort';
  String pid = 'tomato';
  int pack = 1;
  String? sheetPid;
  bool locationOpen = false;
  String addressId = 'home';
  bool addingAddress = false;
  String newTag = 'Home';
  String newLine = '';
  String newSub = '';

  final List<Address> savedAddresses = [
    Address(id: 'home', tag: 'HOME', line: 'Godrej Hill, Kondhwa', sub: 'B-1204, Godrej Hill Apartments, Kondhwa, Pune 411048'),
    Address(id: 'work', tag: 'WORK', line: 'Cybercity Business Park', sub: '4th Floor, Wing B, Magarpatta Road, Pune 411013'),
    Address(id: 'other', tag: 'OTHER', line: "Mom's place", sub: '14, Sahyog Society, Kothrud, Pune 411038'),
  ];
  final List<Address> customAddresses = [];

  List<Address> get allAddresses => [...savedAddresses, ...customAddresses];
  Address get selectedAddress {
    if (addressId == 'gps') return Address(id: 'gps', tag: 'GPS', line: 'Current location', sub: 'Detecting your address…');
    return allAddresses.firstWhere((a) => a.id == addressId, orElse: () => allAddresses.first);
  }

  bool navVisible = true;
  bool addressVisible = true;

  CatTheme get theme => themes[tab] ?? themes['All']!;
  Color get accent => theme.accent;

  void setNavVisible(bool visible) {
    if (navVisible != visible) {
      navVisible = visible;
      notifyListeners();
    }
  }

  void setAddressVisible(bool visible) {
    if (addressVisible != visible) {
      addressVisible = visible;
      notifyListeners();
    }
  }

  void setScreen(Screen s) { screen = s; navVisible = true; addressVisible = true; notifyListeners(); }
  void setTab(String t) { tab = t; navVisible = true; addressVisible = true; notifyListeners(); }
  void goToCategory(String catName, String tabName) { tab = tabName; cat = catName; sub = 'All'; screen = Screen.list; navVisible = true; addressVisible = true; notifyListeners(); }
  void openList(String catName) { cat = catName; sub = 'All'; screen = Screen.list; navVisible = true; addressVisible = true; notifyListeners(); }
  void setSub(String s2) { sub = s2; notifyListeners(); }
  void setFilter(String f) { filter = filter == f ? '' : f; notifyListeners(); }
  void openProduct(String id) { pid = id; pack = 1; screen = Screen.pdp; navVisible = true; addressVisible = true; notifyListeners(); }
  void setPack(int i) { pack = i; notifyListeners(); }

  void add(String id) { cart[id] = (cart[id] ?? 0) + 1; notifyListeners(); }
  void bump(String id, int d) {
    final n = (cart[id] ?? 0) + d;
    if (n <= 0) {
      cart.remove(id);
    } else {
      cart[id] = n;
    }
    notifyListeners();
  }

  ({int price, int mrp}) keyMeta(String key) {
    final i = key.indexOf('::');
    final pidPart = i < 0 ? key : key.substring(0, i);
    final vIdx = i < 0 ? null : int.parse(key.substring(i + 2));
    final p = byId(pidPart);
    final v = (vIdx != null && p.variants != null) ? p.variants![vIdx] : null;
    return v != null ? (price: v.price, mrp: v.mrp) : (price: p.price, mrp: p.mrp);
  }

  int get cartCount => cart.values.fold(0, (a, b) => a + b);
  int get cartTotal => cart.entries.fold(0, (n, e) => n + keyMeta(e.key).price * e.value);
  int get cartSaved => cart.entries.fold(0, (n, e) => n + (keyMeta(e.key).mrp - keyMeta(e.key).price) * e.value);

  int qtyFor(String id) {
    final p = byId(id);
    if (p.variants != null && p.variants!.length > 1) {
      int total = 0;
      for (var i = 0; i < p.variants!.length; i++) { total += cart['$id::$i'] ?? 0; }
      return total;
    }
    return cart[id] ?? 0;
  }

  void openVariantSheet(String productId) { sheetPid = productId; notifyListeners(); }
  void closeSheet() { sheetPid = null; notifyListeners(); }

  void openLocation() { locationOpen = true; notifyListeners(); }
  void closeLocation() { locationOpen = false; addingAddress = false; notifyListeners(); }
  void useGps() { addressId = 'gps'; locationOpen = false; notifyListeners(); }
  void selectAddress(String id) { addressId = id; locationOpen = false; notifyListeners(); }
  void openAddForm() { addingAddress = true; newTag = 'Home'; newLine = ''; newSub = ''; notifyListeners(); }
  void cancelAddForm() { addingAddress = false; notifyListeners(); }
  void setNewTag(String t) { newTag = t; notifyListeners(); }
  void setNewLine(String v) { newLine = v; notifyListeners(); }
  void setNewSub(String v) { newSub = v; notifyListeners(); }
  void saveNewAddress() {
    if (newLine.trim().isEmpty) return;
    final id = 'custom${DateTime.now().millisecondsSinceEpoch}';
    customAddresses.add(Address(id: id, tag: newTag.toUpperCase(), line: newLine.trim(), sub: newSub.trim().isEmpty ? 'Added manually' : newSub.trim()));
    addressId = id; addingAddress = false; locationOpen = false;
    notifyListeners();
  }
}
