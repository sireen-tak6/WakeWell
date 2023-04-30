import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/main.dart';
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
    /*
    var scHeight = Provider.of<auth>(context).screenHeight;*/
    var scHeight = MediaQuery.of(context).size.height;
    var scWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        child: RadioListTile(
          title: Text(
            label,
            style: TextStyle(fontSize: scWidth * (fontSize - 0.023)),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          value: value,
          groupValue: Group,
          onChanged: onChange,
          contentPadding: EdgeInsets.all(0),
        ),
      ),
    );
  }
}
