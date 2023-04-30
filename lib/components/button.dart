import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';
//import 'package:wakewell/provider/provider.dart';
import 'package:wakewell/main.dart';

import '../provider/provider.dart';

class button extends StatelessWidget {
  final ontap;
  final text;
  var icon;
  button({super.key, required this.ontap, required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    /*
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;*/
    final scWidth = MediaQuery.of(context).size.width;
    final scHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: scHeight > 500 ? scHeight * 0.06 : 50,
        width: scWidth * 0.8,
        child: GestureDetector(
          onTap: ontap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(scHeight * 0.01),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: scHeight > 500 ? scHeight * 0.06 : 50,
                width: scWidth * 0.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(221, 247, 254, 247),
                      Color.fromARGB(218, 197, 218, 195)
                    ],
                  ), //Provider.of<auth>(context).greenGradient,
                  borderRadius: BorderRadius.all(
                    Radius.circular(scHeight * 0.015),
                  ),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: icon != null
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  width: scWidth * 0.08,
                                  height: scWidth * 0.08,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color.fromARGB(115, 138, 152, 128),
                                          Color.fromARGB(192, 92, 104, 83)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(child: icon),
                                )
                              : Container()),
                      Center(
                        child: Text(
                          text,
                          style: TextStyle(
                              fontSize: scWidth * fontSize,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
