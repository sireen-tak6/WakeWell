import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/provider/provider.dart';

class RadioTile extends StatelessWidget {
  final label;
  final value;
  final onChange;
  final Group;
  const RadioTile(
      {super.key, this.label, this.value, this.onChange, this.Group});

  @override
  Widget build(BuildContext context) {
    var scHeight = Provider.of<auth>(context).screenHeight;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RadioListTile(
          title: Text(
            label,
            style: TextStyle(fontSize: scHeight * 0.017),
          ),
          value: value,
          groupValue: Group,
          onChanged: onChange),
    );
  }
}
