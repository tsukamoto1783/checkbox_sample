import 'package:flutter/material.dart';

class CheckboxListTilesVer2 extends StatefulWidget {
  const CheckboxListTilesVer2({Key? key}) : super(key: key);

  @override
  State<CheckboxListTilesVer2> createState() => _CheckboxListTilesVer2();
}

class _CheckboxListTilesVer2 extends State<CheckboxListTilesVer2> {
  final List valueMaps = [
    {'value': 'A', 'checked': false},
    {'value': 'B', 'checked': false},
    {'value': 'C', 'checked': false},
    {'value': 'D', 'checked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("checkbox sample")),
      body: Center(
        child: Column(
          children: valueMaps
              .map((e) => CheckboxListTile(
                  title: Text(e['value']),
                  subtitle: Text(e['checked'] ? "ON" : "OFF"),
                  value: e['checked'],
                  onChanged: (bool? checkedValue) {
                    setState(() {
                      e['checked'] = checkedValue;
                    });
                  }))
              .toList(),
        ),
      ),
    );
  }
}
