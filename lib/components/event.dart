import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wakewell/components/timeField.dart';
import 'package:wakewell/screens/edit.dart';

import '../provider/provider.dart';

class event extends StatelessWidget {
  var id;
  var name;
  late TimeOfDay time;
  final type;
  event(String name, TimeOfDay time, int id, this.type) {
    this.name = name;
    this.id = id;
    this.time = time;
  }

  @override
  Widget build(BuildContext context) {
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(editEvent.routename,
              arguments: {'id': id, 'type': type});
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(scHeight * 0.01),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: scHeight * 0.01),
              padding: EdgeInsets.symmetric(horizontal: scWidth * 0.05),
              height: scHeight * 0.08,
              decoration: BoxDecoration(
                gradient: Provider.of<auth>(context).greenGradient,
                borderRadius: BorderRadius.all(
                  Radius.circular(scHeight * 0.015),
                ),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: scHeight * 0.022),
                  ),
                  Text(
                    time.format(context),
                    style: TextStyle(fontSize: scHeight * 0.022),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
