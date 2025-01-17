import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/components/button.dart';
import 'package:wakewell/provider/provider.dart';
import 'package:wakewell/screens/dayAlarms.dart';
import '../components/frostedAppBar.dart';
import '../components/timeField.dart';
import '../main.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    print('home');
/*
    final scWidth = Provider.of<auth>(context).screenWidth;
    final scHeight = Provider.of<auth>(context).screenHeight;*/
    var scHeight = MediaQuery.of(context).size.height;
    var scWidth = MediaQuery.of(context).size.width;
    // to hide the status bar
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(fit: StackFit.expand, children: [
          Container(
            width: scWidth,
            padding: EdgeInsets.symmetric(horizontal: scWidth * 0.05),
            height: scHeight,
            decoration: BoxDecoration(
                gradient: Provider.of<auth>(context).blueGradient),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: scHeight * 0.08,
                ),
                Container(
                  height: scHeight * 0.25,
                  child: timeFeild(
                    label: "وقت النوم",
                  ),
                ),
                SizedBox(height: scHeight * 0.05),
                Container(
                  height: scHeight * 0.25,
                  child: timeFeild(
                    label: "وقت الإستيقاظ",
                  ),
                ),
                SizedBox(height: scHeight * 0.1),
                button(
                    ontap: () {
                      Provider.of<auth>(context, listen: false).addMeals();
                      Navigator.of(context)
                          .pushReplacementNamed(dayAlarms.routeName);
                    },
                    text: "التالي"),
              ],
            ),
          ),
          FrostedAppBar(
            blurStrengthX: 20,
            blurStrengthY: 20,
            title: Center(
              child: Text(
                'Daily Reminder',
                style: TextStyle(
                  fontSize: scWidth * fontSize,
                  color: Color.fromARGB(255, 81, 84, 70),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
