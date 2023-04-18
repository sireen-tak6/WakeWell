import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/provider/provider.dart';

class button extends StatelessWidget {
  final ontap;
  final text;
  const button({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;

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
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: scHeight * 0.025,
                        fontWeight: FontWeight.w600),
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
