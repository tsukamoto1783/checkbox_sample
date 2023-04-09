import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkedListProvider =
    StateNotifierProvider.autoDispose<CheckedListState, List<bool>>(
  (ref) => CheckedListState(),
);

class CheckedListState extends StateNotifier<List<bool>> {
  CheckedListState() : super(List.generate(4, (index) => false));

  void updateCheckedValue(int index, bool checkedValue) {
    state = [
      for (int i = 0; i < state.length; i++)
        i == index ? checkedValue : state[i],
    ];
  }
}

class CheckboxListTileRiverpodNew extends ConsumerWidget {
  CheckboxListTileRiverpodNew({Key? key}) : super(key: key);
  final List<String> _valueList = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedList = ref.watch(checkedListProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Checkbox + Riverpod List Ver")),
      body: Center(
        child: ListView.separated(
          itemBuilder: (context, index) => CheckboxListTile(
            title: Text(_valueList[index]),
            subtitle: Text(checkedList[index] ? "ON" : "OFF"),
            value: checkedList[index],
            onChanged: (bool? checkedValue) {
              // StateProviderだと、ListやMapの取り扱いは基本的にはNG。
              // なので、ListやMapの要素を変更する場合は、 StateNotifierProviderを使う。
              // 基本的にはリストのような箱の中身が変更になっても、Flutter側では検知してくれない。

              // 以下はNG。直接stateを変更することはできない。
              // StateNotifirerのstateはimmutableなので、外部から直接変更はできない。

              // ref.read(checkedListProvider.notifier).state[index] =
              //     !checkedList[index];

              /// 以下はOK。StateNotifierのstateを変更するには、内部で変更が必要。
              /// なので、StateNotifierの中で定義した、stateを変更するメソッドを呼び出す必要あり。
              ref
                  .watch(checkedListProvider.notifier)
                  .updateCheckedValue(index, checkedValue!);
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
