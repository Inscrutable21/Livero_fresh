import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

void showLocationSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: const _LocationSheet(),
    ),
  ).whenComplete(() => context.read<AppState>().closeLocation());
}

class _LocationSheet extends StatefulWidget {
  const _LocationSheet();
  @override
  State<_LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<_LocationSheet> {
  late TextEditingController lineCtrl;
  late TextEditingController subCtrl;

  @override
  void initState() {
    super.initState();
    lineCtrl = TextEditingController();
    subCtrl = TextEditingController();
  }

  @override
  void dispose() {
    lineCtrl.dispose();
    subCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = MediaQuery.of(context).size.height - bottomInset;
    return Container(
      constraints: BoxConstraints(maxHeight: availableHeight * 0.82),
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 20),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Select delivery location', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF12261C))),
          GestureDetector(onTap: () => Navigator.pop(context), child: Container(width: 28, height: 28, decoration: const BoxDecoration(color: Color(0xFFF2F4F1), shape: BoxShape.circle), alignment: Alignment.center, child: const Text('×', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF12261C))))),
        ]),
        const SizedBox(height: 14),
        Container(
          height: 44, padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: const Color(0xFFF5F6F3), borderRadius: BorderRadius.circular(12)),
          child: const Row(children: [Icon(Icons.search, size: 18, color: Color(0xFF4C6157)), SizedBox(width: 9), Text('Search for area, street name...', style: TextStyle(fontSize: 13.5, color: Color(0x6B12261C)))]),
        ),
        const SizedBox(height: 14),
        Flexible(child: SingleChildScrollView(child: app.addingAddress ? _addForm(context, app) : _list(context, app))),
      ]),
    );
  }

  Widget _list(BuildContext context, AppState app) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        onTap: app.useGps,
        child: Container(
          padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: app.theme.tint.withOpacity(.45), borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            Container(width: 38, height: 38, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(Icons.my_location, size: 19, color: app.accent)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Use current location', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: app.accent)),
              const Text('Enable GPS for the fastest delivery estimate', style: TextStyle(fontSize: 11.5, color: Color(0x8C12261C))),
            ])),
            if (app.addressId == 'gps') Icon(Icons.check, size: 18, color: app.accent),
          ]),
        ),
      ),
      Padding(padding: const EdgeInsets.fromLTRB(4, 0, 4, 8), child: Text('SAVED ADDRESSES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .5, color: Colors.black.withOpacity(.45)))),
      for (final a in app.allAddresses) _addrRow(context, app, a),
      GestureDetector(
        onTap: app.openAddForm,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
          child: Row(children: [
            Container(width: 38, height: 38, decoration: BoxDecoration(border: Border.all(color: const Color(0x40122612), width: 1.4), borderRadius: BorderRadius.circular(11)), alignment: Alignment.center, child: const Text('+', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0x66122612)))),
            const SizedBox(width: 10),
            const Text('Add new address', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Color(0xFF12261C))),
          ]),
        ),
      ),
    ]);
  }

  Widget _addrRow(BuildContext context, AppState app, Address a) {
    final on = app.addressId == a.id;
    return GestureDetector(
      onTap: () => app.selectAddress(a.id),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0x12122612)))),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFF4F5F2), borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.home_outlined, size: 18, color: Color(0xFF4C6157))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: on ? app.theme.tint : const Color(0xFFF2F4F1), borderRadius: BorderRadius.circular(5)), child: Text(a.tag, style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, letterSpacing: .5, color: on ? app.accent : const Color(0x8012261C)))),
            const SizedBox(height: 4),
            Text(a.line, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Color(0xFF12261C))),
            const SizedBox(height: 2),
            Text(a.sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, color: Color(0x8012261C))),
          ])),
          if (on) Icon(Icons.check, size: 18, color: app.accent),
        ]),
      ),
    );
  }

  Widget _addForm(BuildContext context, AppState app) {
    final canSave = app.newLine.trim().isNotEmpty;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('LABEL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .5, color: Color(0x8012261C))),
      const SizedBox(height: 8),
      Row(children: [
        for (final t in ['Home', 'Work', 'Other']) _tagPick(app, t),
      ]),
      const SizedBox(height: 16),
      const Text('ADDRESS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .5, color: Color(0x8012261C))),
      const SizedBox(height: 8),
      TextField(controller: lineCtrl, onChanged: app.setNewLine, decoration: InputDecoration(hintText: 'Flat / house no., building name', contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: Color(0x24122612))))),
      const SizedBox(height: 10),
      TextField(controller: subCtrl, onChanged: app.setNewSub, decoration: InputDecoration(hintText: 'Area, landmark, city', contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: Color(0x24122612))))),
      const SizedBox(height: 18),
      Row(children: [
        Expanded(child: GestureDetector(onTap: app.cancelAddForm, child: Container(height: 46, alignment: Alignment.center, decoration: BoxDecoration(border: Border.all(color: const Color(0x26122612), width: 1.4), borderRadius: BorderRadius.circular(12)), child: const Text('Cancel', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Color(0xFF12261C)))))),
        const SizedBox(width: 10),
        Expanded(flex: 2, child: GestureDetector(
          onTap: canSave ? () { app.saveNewAddress(); Navigator.pop(context); } : null,
          child: Container(height: 46, alignment: Alignment.center, decoration: BoxDecoration(color: app.accent.withOpacity(canSave ? 1 : .45), borderRadius: BorderRadius.circular(12)), child: const Text('Save address', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.white))),
        )),
      ]),
    ]);
  }

  Widget _tagPick(AppState app, String t) {
    final on = app.newTag == t;
    return Expanded(
      child: GestureDetector(
        onTap: () => app.setNewTag(t),
        child: Container(
          margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(vertical: 9), alignment: Alignment.center,
          decoration: BoxDecoration(color: on ? app.accent : const Color(0xFFF2F4F1), borderRadius: BorderRadius.circular(10)),
          child: Text(t, style: TextStyle(fontSize: 12.5, fontWeight: on ? FontWeight.w600 : FontWeight.w400, color: on ? Colors.white : const Color(0xA6122612))),
        ),
      ),
    );
  }
}
