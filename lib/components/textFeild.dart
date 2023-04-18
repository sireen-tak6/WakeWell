import 'package:flutter/material.dart';

class textFeild extends StatefulWidget {
  final controller;
  final focus;
  final name;
  final valid;
  final save;
  final suffix;
  final val;
  final enabled;
  final type;
  textFeild({
    Key? key,
    this.controller,
    this.focus,
    this.name,
    this.valid,
    this.save,
    this.suffix,
    this.val,
    this.enabled,
    this.type,
  }) : super(key: key);

  @override
  State<textFeild> createState() => _textFeildState();
}

class _textFeildState extends State<textFeild> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
          initialValue: widget.val,
          controller: widget.controller,
          focusNode: widget.focus,
          cursorColor: Theme.of(context).primaryColorLight,
          decoration: InputDecoration(
            suffixText: widget.suffix,
            labelStyle: TextStyle(color: Theme.of(context).primaryColorLight),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(218, 78, 161, 70))),
            labelText: widget.name,
            border: OutlineInputBorder(),
          ),
          enabled: widget.enabled,
          keyboardType: widget.type,
          validator: widget.valid,
          onChanged: widget.save),
    );
  }
}
