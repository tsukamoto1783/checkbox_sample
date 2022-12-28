import 'package:flutter/material.dart';

class CheckboxSingle extends StatefulWidget {
  const CheckboxSingle({Key? key}) : super(key: key);

  @override
  State<CheckboxSingle> createState() => _CheckboxSingleState();
}

class _CheckboxSingleState extends State<CheckboxSingle> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("hoge")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isChecked ? "ON" : "OFF"),
            Checkbox(
              value: _isChecked,
              onChanged: (value) {
                setState(() {
                  _isChecked = !_isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
