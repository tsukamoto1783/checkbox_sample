import 'package:checkbox_sample/checkboxListTileRiverpod.dart';
import 'package:checkbox_sample/checkboxListTiles.dart';
import 'package:checkbox_sample/checkboxListTilesRiverpodVer2.dart';
import 'package:checkbox_sample/checkboxListTilesVer2.dart';
import 'package:checkbox_sample/checkboxRiverpod.dart';
import 'package:checkbox_sample/checkbox_single.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final Map<int, Map<String, dynamic>> map = {
    0: {'pageName': 'checkbox + Stateful', 'className': const CheckboxSingle()},
    1: {
      'pageName': 'checkboxListTile List Ver + Stateful',
      'className': const CheckboxListTiles(),
    },
    2: {
      'pageName': 'checkboxListTile Map Ver + Stateful',
      'className': const CheckboxListTilesVer2(),
    },
    3: {
      'pageName': 'checkbox + riverpod',
      'className': CheckboxRiverpod(),
    },
    4: {
      'pageName': 'checkboxListTile List Ver + riverpod',
      'className': CheckboxListTileRiverpod(),
    },
    5: {
      'pageName': 'checkboxListTile Map Ver + riverpod',
      'className': CheckboxListTileRiverpodVer2(),
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
