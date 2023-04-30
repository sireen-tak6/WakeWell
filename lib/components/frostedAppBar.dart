import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/provider/provider.dart';

class FrostedAppBar extends StatefulWidget {
  double? height;
  Widget? title;
  Widget? leading;
  List<Widget>? actions;
  Color? color;
  double? blurStrengthX;
  double? blurStrengthY;
  FrostedAppBar({
    this.height,
    this.actions,
    this.blurStrengthX,
    this.blurStrengthY,
    this.color,
    this.leading,
    this.title,
  });

  @override
  _FrostedAppBarState createState() => _FrostedAppBarState();
}

class _FrostedAppBarState extends State<FrostedAppBar> {
  @override
  Widget build(BuildContext context) {
    /*
    final scWidth = Provider.of<auth>(context, listen: false).screenWidth;
    final scHeight = Provider.of<auth>(context, listen: false).screenHeight;*/
    var scHeight = MediaQuery.of(context).size.height;
    var scWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Positioned(
        top: 0,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blurStrengthX ?? 10,
              sigmaY: widget.blurStrengthY ?? 10,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: scHeight * 0.01, horizontal: scWidth * 0.05),
              color: widget.color,
              alignment: Alignment.center,
              width: scWidth,
              height: widget.height ?? 100,
              child: Row(
                children: [
                  Container(
                    width: scWidth * 0.07,
                    color: Colors.transparent,
                    child: widget.leading,
                  ),
                  Expanded(
                    child: Container(child: widget.title ?? Container()),
                  ),
                  Container(
                    width: scWidth * 0.05,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
