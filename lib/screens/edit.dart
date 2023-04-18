import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/components/timeField.dart';

import '../components/RadioTile.dart';
import '../components/button.dart';
import '../components/frostedAppBar.dart';
import '../components/textFeild.dart';
import '../provider/provider.dart';

class editEvent extends StatefulWidget {
  static var change = false;

  static var event;
  static final routename = 'editEvent';
  static TimeOfDay? time;

  final id;
  final type;
  editEvent({
    super.key,
    this.id,
    this.type,
  });

  @override
  State<editEvent> createState() => _editEventState();
}

class _editEventState extends State<editEvent> {
  final _formKey = GlobalKey<FormState>();
  FocusNode namefocus = FocusNode();
  FocusNode timefocus = FocusNode();
  FocusNode notesfocus = FocusNode();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(() {
      setState(() {});
    });
    notesController.addListener(() {
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
  String? notes;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (!load) {
      if (args['type'] == 'meal') {
        var _data =
            Provider.of<auth>(context).meals[int.parse(args['id'].toString())];
        editEvent.event = {
          'name': _data['name'],
          'time': _data['time'],
          'notes': _data['notes']
        };
      } else if (args['type'] == 'med') {
        print(args['id']);
        var data = Provider.of<auth>(context)
            .medicens[int.parse(args['id'].toString())];
        editEvent.event = {
          'name': data['name'],
          'time': data['time'],
          'notes': data['notes']
        };
      } else if (args['type'] == 'sleep') {
        editEvent.event = {
          'name': Provider.of<auth>(context).sleepname,
          'time': Provider.of<auth>(context).getSleepTime,
          'notes': Provider.of<auth>(context).sleepNotes
        };
      } else {
        editEvent.event = {
          'name': Provider.of<auth>(context).wakename,
          'time': Provider.of<auth>(context).getWakeTime,
          'notes': Provider.of<auth>(context).wakeNotes
        };
      }
      nameController.text = editEvent.event['name'];
      notesController.text = editEvent.event['notes'];
      name = editEvent.event['name'];
      notes = editEvent.event['notes'];
      editEvent.time = editEvent.event['time'];
      load = true;
    }
    var scHeight = Provider.of<auth>(context).screenHeight;
    var scWidth = Provider.of<auth>(context).screenWidth;

    print(widget.type);
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
                        SizedBox(
                          height: scHeight * 0.12,
                        ),
                        Container(
                          height:
                              scHeight - scWidth * 0.15 * 2 - scHeight * 0.12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              textFeild(
                                controller: nameController,
                                focus: namefocus,
                                name: "الاسم :",
                                valid: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'يرجى إدخال الاسم ';
                                  }
                                  return null;
                                },
                                save: (value) {
                                  setState(() {
                                    name = value;
                                    nameController.text = value;
                                    if (value != editEvent.event['name']) {
                                      editEvent.change = true;
                                    }
                                  });
                                },
                                suffix: "",
                                enabled: true,
                                type: TextInputType.text,
                              ),
                              SizedBox(height: scHeight * 0.05),
                              textFeild(
                                controller: notesController,
                                focus: notesfocus,
                                name: "الملاحظات :",
                                valid: (value) {
                                  return null;
                                },
                                save: (value) {
                                  notes = value;
                                  setState(() {
                                    if (value != editEvent.event['notes']) {
                                      editEvent.change = true;
                                    }
                                  });
                                },
                                suffix: "",
                                enabled: true,
                                type: TextInputType.text,
                              ),
                              SizedBox(height: scHeight * 0.05),
                              Container(
                                height: scHeight * 0.25,
                                child: timeFeild(
                                  label: "الوقت",
                                  time: editEvent.time,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: scWidth * 0.3,
                                    child: button(
                                        ontap: editEvent.change
                                            ? () {
                                                Provider.of<auth>(context,
                                                        listen: false)
                                                    .editEvent(
                                                        args['type'],
                                                        args['id'],
                                                        name,
                                                        editEvent.time,
                                                        notes,
                                                        context);
                                              }
                                            : () {},
                                        text: "حفظ"),
                                  ),
                                  if (args['type'] == 'med')
                                    Container(
                                        width: scWidth * 0.3,
                                        child: button(
                                            ontap: () {
                                              Provider.of<auth>(context,
                                                      listen: false)
                                                  .deleteEvent(
                                                      args['id'], context);
                                            },
                                            text: "حذف"))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FrostedAppBar(
              blurStrengthX: 20,
              blurStrengthY: 20,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: Center(
                child: Text(
                  editEvent.event['name'],
                  style: TextStyle(
                    fontSize: Provider.of<auth>(context).screenHeight * 0.035,
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