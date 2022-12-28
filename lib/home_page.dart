import 'package:checkbox_sample/checkboxListTiles.dart';
import 'package:checkbox_sample/checkboxListTilesVer2.dart';
import 'package:checkbox_sample/checkbox_single.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final Map<int, Map<String, dynamic>> map = {
    0: {'pageName': 'checkbox', 'className': const CheckboxSingle()},
    1: {
      'pageName': 'checkbox_multi',
      'className': const CheckboxListTiles(),
    },
    2: {
      'pageName': 'checkbox_multi_ver2',
      'className': const CheckboxListTilesVer2(),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      /// ListViewの三種類ぐらい違いを実際に実装してみて試してみたい。
      child: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          // leading: icon,
          title: Text(
            map[index]!['pageName'].toString(),
            style: const TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => map[index]!['className']),
            );
          },
        ),
        separatorBuilder: (context, index) {
          // print('separator: $index');
          return const Divider(height: 0.5);
        },
        itemCount: map.length,
      ),
    );
  }
}
