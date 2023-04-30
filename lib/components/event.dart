import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wakewell/components/timeField.dart';
import 'package:wakewell/main.dart';
import 'package:wakewell/screens/edit.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    var scHeight = MediaQuery.of(context).size.height;
    var scWidth = MediaQuery.of(context)
        .size
        .width; /*
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;*/
    String image = type == "sleep"
        ? "assets/sleep.svg"
        : type == "wake"
            ? "assets/wake2.svg"
            : type == "meal"
                ? "assets/food.svg"
                : "assets/medicine.svg";
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
                  Container(
                    width: scHeight * 0.05,
                    padding: EdgeInsets.all(scHeight * 0.01),
                    height: scHeight * 0.05,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(115, 138, 152, 128),
                            Color.fromARGB(192, 92, 104, 83)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(scWidth * 0.2)),
                    child: Container(
                        width: scHeight * 0.025,
                        height: scHeight * 0.025,
                        child: SvgPicture.asset(
                          image,
                        )),
                  ),
                  SizedBox(width: scWidth * 0.05),
                  Text(
                    name,
                    style: TextStyle(fontSize: scWidth * fontSize),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    time.format(context),
                    style: TextStyle(fontSize: scWidth * fontSize),
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
