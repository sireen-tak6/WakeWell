import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/provider/provider.dart';
import 'package:wakewell/screens/edit.dart';

import '../main.dart';

class timeFeild extends StatefulWidget {
  String? label;
  TimeOfDay? time;
  var variable;
  timeFeild({this.label, this.time, this.variable});

  @override
  State<timeFeild> createState() => _timeFeildState();
}

class _timeFeildState extends State<timeFeild> {
  @override
  Widget build(BuildContext context) {
    /*
    final scWidth = Provider.of<auth>(context, listen: true).screenWidth;
    final scHeight = Provider.of<auth>(context, listen: true).screenHeight;*/
    var scHeight = MediaQuery.of(context).size.height;
    var scWidth = MediaQuery.of(context).size.width;
    TimeOfDay selectedDate = widget.label == "وقت النوم"
        ? Provider.of<auth>(context, listen: true).getSleepTime
        : widget.label == "الوقت"
            ? widget.time
            : Provider.of<auth>(context, listen: true).getWakeTime;

    Future<void> _selectDate(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        cancelText: 'إلغاء',
        confirmText: 'حفظ',
        helpText: 'اختر الوقت',
        initialEntryMode: TimePickerEntryMode.dialOnly,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Theme(
                data: Theme.of(context).copyWith(
                  timePickerTheme: TimePickerThemeData(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(
                            width: 10,
                            color: Color.fromARGB(255, 217, 239, 245))),
                    backgroundColor: Color.fromARGB(255, 217, 239, 245),
                    dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.selected)
                            ? Theme.of(context).primaryColorLight
                            : Color.fromARGB(218, 197, 218, 195)),
                    dayPeriodTextColor: MaterialStateColor.resolveWith(
                        (states) => states.contains(MaterialState.selected)
                            ? Color.fromARGB(218, 197, 218, 195)
                            : Theme.of(context).primaryColorLight),
                    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                        states.contains(MaterialState.selected)
                            ? Theme.of(context).primaryColorLight
                            : Color.fromARGB(218, 197, 218, 195)),
                    hourMinuteTextColor: MaterialStateColor.resolveWith(
                        (states) => states.contains(MaterialState.selected)
                            ? Colors.white
                            : Theme.of(context).primaryColorLight),
                    dialHandColor: Theme.of(context).primaryColorLight,
                    dialBackgroundColor: Color.fromARGB(218, 197, 218, 195),
                    hourMinuteTextStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    dayPeriodTextStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                    helpTextStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 92, 104, 83)),
                    dialTextColor: Colors.white,
                    entryModeIconColor: Color.fromARGB(218, 197, 218, 195),
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(218, 197, 218, 195)),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColorLight),
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Color.fromARGB(218, 197, 218, 195)),
                    ),
                  ),
                ),
                child: child!),
          );
        },
        context: context,
        initialTime: selectedDate,
      );

      if (picked != null && picked != selectedDate) {
        if (widget.label == "وقت النوم") {
          Provider.of<auth>(context, listen: false).setSleepTime = picked;
        } else if (widget.label == "الوقت") {
          setState(() {
            widget.time = picked;
            editEvent.time = picked;
          });
        } else {
          Provider.of<auth>(context, listen: false).setAwakeTime = picked;
        }
      }
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0,
            sigmaY: 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white70, Colors.white30],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(scHeight * 0.02),
              ),
            ),
            child: ClipRect(
              child: Container(
                width: scWidth * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          gradient: Provider.of<auth>(context).greenGradient,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ],
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(scHeight * 0.02),
                            topRight: Radius.circular(scHeight * 0.02),
                          )),
                      width: scWidth,
                      height: scHeight * 0.06,
                      child: Text(
                        widget.label ?? "",
                        style: TextStyle(
                            fontSize: scWidth * fontSize,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${selectedDate.format(context)}',
                            style: TextStyle(
                                fontSize: scWidth * fontSize,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(height: scHeight * 0.02),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              height: scHeight * 0.045,
                              width: scWidth * 0.25,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3),
                                  )
                                ],
                                gradient:
                                    Provider.of<auth>(context).greenGradient,
                                borderRadius:
                                    BorderRadius.circular(scHeight * 0.01),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'ضبط الوقت',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: scWidth * fontSize),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
