import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckboxRiverpod extends ConsumerWidget {
  CheckboxRiverpod({Key? key}) : super(key: key);

  final AutoDisposeStateProvider<bool> _isCheckedProvider =
      StateProvider.autoDispose((ref) {
    return false;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isChecked = ref.watch(_isCheckedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkbox + Riverpod")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isChecked ? "ON" : "OFF"),
            Checkbox(
              value: isChecked,
              onChanged: (bool? checkedValue) {
                ref.read(_isCheckedProvider.notifier).state = checkedValue!;
              },
            ),
          ],
        ),
      ),
    );
  }
}
