import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxListTileRiverpod extends ConsumerWidget {
  CheckboxListTileRiverpod({Key? key}) : super(key: key);
  final List<String> _valueList = ['A', 'B', 'C', 'D'];
  final AutoDisposeStateProvider<List<bool>> _checkedListProvider =
      StateProvider.autoDispose<List<bool>>((ref) {
    return List.generate(4, (index) => false);
  });

  final ProviderListenable<dynamic> _changeNotifierProvider =
      ChangeNotifierProvider((ref) {
    return ChangeNotifier();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<bool> checkedList = ref.watch(_checkedListProvider);
    final changeNotifier = ref.watch(_changeNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkbox + Riverpod List Ver")),
      body: Center(
        child: ListView.separated(
          itemBuilder: (context, index) => CheckboxListTile(
            title: Text(_valueList[index]),
            subtitle: Text(checkedList[index] ? "ON" : "OFF"),
            value: checkedList[index],
            onChanged: (bool? checkedValue) {
              ref.read(_checkedListProvider.notifier).state[index] =
                  checkedValue!;
              changeNotifier.notifyListeners();
            },
          ),
          separatorBuilder: (context, index) {
            return const Divider(height: 0.5);
          },
          itemCount: _valueList.length,
        ),
      ),
    );
  }
}
