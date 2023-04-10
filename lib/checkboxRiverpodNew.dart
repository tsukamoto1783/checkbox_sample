import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkedListProvider =
    StateNotifierProvider.autoDispose<CheckedListState, List<bool>>(
  (ref) => CheckedListState(),
);

class CheckedListState extends StateNotifier<List<bool>> {
  /// 親クラスであるStateNotifierのコンストラクタをsuperで呼び出し、StateNotifierのstateに初期値を設定する。
  /// 以下の場合だと、state=[false, false, false, false]となる。
  /// 親クラスのstateを継承するので、CheckedListStateクラスのstateも同じ初期値が設定される。
  CheckedListState() : super(List.generate(4, (index) => false));

  /// stateのList[index]の値を、checkedValueに変更し、stateを更新（上書き）する。
  /// stateが更新されると、UIが再ビルドされる。
  void updateListElement(int index, bool updateValue) {
    state = [
      for (int i = 0; i < state.length; i++)
        i == index ? updateValue : state[i],
    ];
  }
}

// class名は変更する
class CheckboxListTileRiverpodNew extends ConsumerWidget {
  CheckboxListTileRiverpodNew({Key? key}) : super(key: key);
  final List<String> _valueList = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedList = ref.watch(checkedListProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text("StateProvider StateNotifierProvider Sample")),
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
                  .updateListElement(index, checkedValue!);
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
