import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxListTileRiverpodVer2 extends ConsumerWidget {
  CheckboxListTileRiverpodVer2({Key? key}) : super(key: key);
  final AutoDisposeStateProvider<List<Map<String, dynamic>>>
      _checkedMapStateProvider =
      StateProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
    return [
      {'value': 'A', 'checked': false},
      {'value': 'B', 'checked': false},
      {'value': 'C', 'checked': false},
      {'value': 'D', 'checked': false},
    ];
  });

  final ProviderListenable<dynamic> _changeNotifierProvider =
      ChangeNotifierProvider((ref) {
    return ChangeNotifier();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> checkedMap =
        ref.watch(_checkedMapStateProvider);
    final changeNotifier = ref.watch(_changeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkbox + Riverpod Map Ver")),
      body: Center(
        child: Column(
          children: checkedMap
              .map((e) => CheckboxListTile(
                  title: Text(e['value']),
                  subtitle: Text(e['checked'] ? "ON" : "OFF"),
                  value: e['checked'],
                  onChanged: (bool? checkedValue) {
                    e['checked'] = checkedValue;
                    changeNotifier.notifyListeners();
                  }))
              .toList(),
        ),
      ),
    );
  }
}
