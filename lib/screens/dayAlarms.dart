import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/components/button.dart';
import 'package:wakewell/components/event.dart';
import 'package:wakewell/screens/newEvent.dart';
import '../components/frostedAppBar.dart';
import '../provider/provider.dart';

class dayAlarms extends StatelessWidget {
  static String routeName = 'dayAlarms';
  dayAlarms({super.key});

  @override
  Widget build(BuildContext context) {
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;
    var _medicens = Provider.of<auth>(context).medicens;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(fit: StackFit.expand, children: [
          Container(
            height: scHeight,
            width: scWidth,
            decoration: BoxDecoration(
                gradient: Provider.of<auth>(context).blueGradient),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: scWidth * 0.05),
                  height: scHeight * 0.85,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: scHeight * 0.12,
                      ),
                      event(
                        Provider.of<auth>(context).sleepname,
                        Provider.of<auth>(context).getSleepTime,
                        0,
                        'sleep',
                      ),
                      event(Provider.of<auth>(context).wakename,
                          Provider.of<auth>(context).getWakeTime, 1, 'wake'),
                      event(
                          Provider.of<auth>(context).meals[0]['name'],
                          Provider.of<auth>(context).meals[0]['time'],
                          0,
                          'meal'),
                      event(
                          Provider.of<auth>(context).meals[1]['name'],
                          Provider.of<auth>(context).meals[1]['time'],
                          1,
                          'meal'),
                      event(
                          Provider.of<auth>(context).meals[2]['name'],
                          Provider.of<auth>(context).meals[2]['time'],
                          2,
                          'meal'),
                      for (var med in _medicens)
                        event(med['name'], med['time'], med['id'], 'med')
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                button(
                    ontap: () {
                      Navigator.of(context).pushNamed(newEvent.routeName);
                    },
                    text: "منبه جديد"),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          FrostedAppBar(
            blurStrengthX: 20,
            blurStrengthY: 20,
            title: Center(
              child: Text(
                'WakeWell',
                style: TextStyle(
                  fontSize: Provider.of<auth>(context).screenHeight * 0.035,
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
