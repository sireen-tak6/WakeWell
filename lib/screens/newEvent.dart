import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/components/RadioTile.dart';
import 'package:wakewell/components/button.dart';
import 'package:wakewell/components/textFeild.dart';

import '../components/frostedAppBar.dart';
import '../main.dart';
import '../provider/provider.dart';

class newEvent extends StatefulWidget {
  static String routeName = 'newEvent';
  const newEvent({super.key});

  @override
  State<newEvent> createState() => _newEventState();
}

class _newEventState extends State<newEvent> {
  final _formKey = GlobalKey<FormState>();
  FocusNode namefocus = FocusNode();
  FocusNode timefocus = FocusNode();
  FocusNode notesfocus = FocusNode();
  final TextEditingController notesController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController foodController = TextEditingController();
  final TextEditingController timesController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {});
    });
    notesController.addListener(() {
      setState(() {});
    });
    timeController.addListener(() {
      setState(() {});
    });
    foodController.addListener(() {
      setState(() {});
    });
    timesController.addListener(() {
      setState(() {});
    });
    timefocus.addListener(() {
      setState(() {});
    });
    notesfocus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  // Form values
  String? name;
  String? time;
  String? notes;

  // Choices
  String? choice1 = "none";
  String? choice2 = "once";

  @override
  Widget build(BuildContext context) {
    /*
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;*/
    var scHeight = MediaQuery.of(context).size.height;
    var scWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                height: scHeight,
                width: scWidth,
                decoration: BoxDecoration(
                    gradient: Provider.of<auth>(context).blueGradient),
                child: Padding(
                  padding: EdgeInsets.all(scWidth * 0.05),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Container(
                          height: scHeight * 0.8,
                          padding: EdgeInsets.only(bottom: scHeight * 0.05),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: scHeight * 0.1,
                              ),
                              textFeild(
                                controller: nameController,
                                name: 'الاسم',
                                focus: namefocus,
                                valid: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يرجى إدخال الاسم ';
                                  }
                                  return null;
                                },
                                save: (value) {
                                  name = value;
                                  print(name);
                                },
                                suffix: '',
                                enabled: true,
                                type: TextInputType.name,
                              ),
                              SizedBox(height: scHeight * 0.05),
                              Row(
                                children: [
                                  Expanded(
                                    child: RadioTile(
                                      Group: choice1,
                                      value: 'before',
                                      label: "قبل الطعام",
                                      onChange: (value) {
                                        setState(() {
                                          choice1 = value.toString();
                                          print(choice1);
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioTile(
                                      Group: choice1,
                                      value: 'after',
                                      label: "بعد الطعام",
                                      onChange: (value) {
                                        setState(() {
                                          choice1 = value.toString();
                                          print(choice1);
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioTile(
                                      Group: choice1,
                                      value: 'none',
                                      label: "أخرى",
                                      onChange: (value) {
                                        setState(() {
                                          choice1 = value.toString();
                                          print(choice1);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: scHeight * 0.05),
                              textFeild(
                                controller: timeController,
                                name: 'فرق الوقت',
                                focus: timefocus,
                                valid: (value) {
                                  if (choice1 != 'none' &&
                                      (value == null || value.isEmpty)) {
                                    return 'يرجى إدخال الوقت';
                                  }
                                  if (choice1 != 'none' &&
                                      int.parse(value!) > 24) {
                                    return "يرجى إدخال وقت صحيح";
                                  }
                                  return null;
                                },
                                save: (value) {
                                  time = value;
                                  print(time);
                                },
                                suffix: 'ساعة',
                                enabled: choice1 != 'none',
                                type: TextInputType.number,
                              ),
                              SizedBox(height: scHeight * 0.05),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'عدد مرات تناول الدواء :',
                                  textAlign: TextAlign.start,
                                  style:
                                      TextStyle(fontSize: scWidth * fontSize),
                                ),
                              ),
                              SizedBox(height: scHeight * 0.05),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: RadioTile(
                                        Group: choice2,
                                        value: 'once',
                                        label: 'مرة',
                                        onChange: (value) {
                                          setState(() {
                                            choice2 = value.toString();
                                            print(choice2);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RadioTile(
                                        Group: choice2,
                                        value: 'twice',
                                        label: 'مرتين',
                                        onChange: (value) {
                                          setState(() {
                                            choice2 = value.toString();
                                            print(choice2);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RadioTile(
                                        Group: choice2,
                                        value: 'three_times',
                                        label: 'ثلاث مرات',
                                        onChange: (value) {
                                          setState(() {
                                            choice2 = value.toString();
                                            print(choice2);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: scHeight * 0.05),
                              textFeild(
                                  controller: notesController,
                                  focus: notesfocus,
                                  name: "ملاحظات",
                                  valid: (value) {
                                    return null;
                                  },
                                  save: (value) {
                                    setState(() {
                                      notes = value;
                                      print(notes);
                                    });
                                  },
                                  suffix: "",
                                  enabled: true,
                                  type: TextInputType.text),
                            ],
                          ),
                        ),
                        Container(
                          height: scHeight * 0.05,
                          child: button(
                              ontap: () {
                                choice1 == "none"
                                    ? Provider.of<auth>(context, listen: false)
                                        .newEvent(
                                        name,
                                        choice2,
                                        notes ?? "",
                                        choice1,
                                        context,
                                        _formKey,
                                      )
                                    : Provider.of<auth>(context, listen: false)
                                        .newEvent(name, choice2, notes ?? "",
                                            choice1, context, _formKey,
                                            time: time);
                              },
                              text: "حفظ"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FrostedAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              blurStrengthX: 20,
              blurStrengthY: 20,
              title: Center(
                child: Text(
                  'تذكير جديد',
                  style: TextStyle(
                    fontSize: scHeight * 0.035,
                    color: Color.fromARGB(255, 81, 84, 70),
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
