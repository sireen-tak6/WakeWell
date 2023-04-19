import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakewell/main.dart';
import 'package:wakewell/screens/dayAlarms.dart';
import 'notifications.dart';

class auth with ChangeNotifier {
  static SharedPreferences? sp;

  final _greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(221, 247, 254, 247),
      Color.fromARGB(218, 197, 218, 195)
    ],
  );

  final _whiteGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white70, Colors.white30],
  );

  final _blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 217, 239, 245),
      Color.fromARGB(255, 154, 198, 209)
    ],
  );
  TimeOfDay _wakeTime = TimeOfDay.fromDateTime(
      DateTime(2023, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute)
          .add(Duration(hours: 8)));
  String _wakeNotes = "";
  String _wakename = "";
  String _sleepNotes = "";
  String _sleepName = "";
  TimeOfDay _sleepTime = TimeOfDay.now();
  List<Map<String, Object>> _meals = [
    {'meal': TimeOfDay.now(), 'notes': "", 'name': 'الوجبة الأولى'},
    {'meal': TimeOfDay.now(), 'notes': "", 'name': 'الوجبة الثانية'},
    {'meal': TimeOfDay.now(), 'notes': "", 'name': 'الوجبة الثالثة'}
  ];
  TimeOfDay _meal1Time = TimeOfDay.now();
  TimeOfDay _meal2Time = TimeOfDay.now();
  TimeOfDay _meal3Time = TimeOfDay.now();

  var _medicens = [];
  bool _load = false;
  get load => _load;
  get getWakeTime => _wakeTime;
  get getSleepTime => _sleepTime;
  get greenGradient => _greenGradient;
  get whiteGradient => _whiteGradient;
  get blueGradient => _blueGradient;
  get medicens => _medicens;
  get sleepNotes => _sleepNotes;
  get wakeNotes => _wakeNotes;
  get wakename => _wakename;
  get sleepname => _sleepName;
  get meals {
    return [
      {
        'name': _meals[0]['name'],
        'time': _meals[0]['meal'],
        'notes': _meals[0]['notes']
      },
      {
        'name': _meals[1]['name'],
        'time': _meals[1]['meal'],
        'notes': _meals[1]['notes']
      },
      {
        'name': _meals[2]['name'],
        'time': _meals[2]['meal'],
        'notes': _meals[2]['notes']
      }
    ];
  }

  set setAwakeTime(
    TimeOfDay time,
  ) {
    _wakeTime = time;
    notifyListeners();
  }

  set setSleepTime(TimeOfDay time) {
    _sleepTime = time;
    DateTime dateTime = DateTime(2023, 1, 1, time.hour, time.minute);
    DateTime eightHoursLater = dateTime.add(Duration(hours: 8));
    _wakeTime = TimeOfDay.fromDateTime(eightHoursLater);
    notifyListeners();
  }

  void saveEvents(String key, value) async {
    var sp = await SharedPreferences.getInstance();
    var eventData = json.encode(value);
    await sp.setString(key, eventData);
  }

  addMeals() async {
    _sleepName = 'وقت النوم';
    _wakename = 'وقت الإستيقاظ';
    var sp = await SharedPreferences.getInstance();
    saveEvents('wake', {
      'name': 'وقت الإستيقاظ',
      'time': _wakeTime.hour.toString() + ":" + _wakeTime.minute.toString(),
      'notes': _wakeNotes
    });
    noti.showBigTextNotification(
        id: -5,
        title: _wakename,
        body: _wakeNotes,
        hour: _wakeTime.hour,
        minute: _wakeTime.minute,
        fln: flnp);
    saveEvents('sleep', {
      'name': 'وقت النوم',
      'time': _sleepTime.hour.toString() + ":" + _sleepTime.minute.toString(),
      'notes': _sleepNotes
    });
    noti.showBigTextNotification(
        id: -4,
        title: _sleepName,
        body: _sleepNotes,
        hour: _sleepTime.hour,
        minute: _sleepTime.minute,
        fln: flnp);
    DateTime _wakeDateTime =
        DateTime(2023, 1, 1, _wakeTime.hour, _wakeTime.minute);
    DateTime meal1Time = _wakeDateTime.add(Duration(hours: 1));
    TimeOfDay _meal1 = TimeOfDay.fromDateTime(meal1Time);

    DateTime meal2Time = _wakeDateTime.add(Duration(hours: 7));
    TimeOfDay _meal2 = TimeOfDay.fromDateTime(meal2Time);

    DateTime meal3Time = _wakeDateTime.add(Duration(hours: 13));
    TimeOfDay _meal3 = TimeOfDay.fromDateTime(meal3Time);
    var _mealsString = [
      {
        'name': 'الوجبة الأولى',
        'meal': _meal1.hour.toString() + ":" + _meal1.minute.toString(),
        'notes': ""
      },
      {
        'name': 'الوجبة الثانية',
        'meal': _meal2.hour.toString() + ":" + _meal2.minute.toString(),
        'notes': ""
      },
      {
        'name': 'الوجبة الثالثة',
        'meal': _meal3.hour.toString() + ":" + _meal3.minute.toString(),
        'notes': ""
      }
    ];
    _meals = [
      {'meal': _meal1, 'notes': "", 'name': 'الوجبة الأولى'},
      {'meal': _meal2, 'notes': "", 'name': 'الوجبة الثانية'},
      {'meal': _meal3, 'notes': "", 'name': 'الوجبة الثالثة'}
    ];
    _meal1Time = _meal1;
    _meal2Time = _meal2;
    _meal3Time = _meal3;
    print(_mealsString);
    noti.showBigTextNotification(
        id: -3,
        title: _meals[0]['name'].toString(),
        body: _meals[0]['notes'].toString(),
        hour: _meal1Time.hour,
        minute: _meal1Time.minute,
        fln: flnp);
    noti.showBigTextNotification(
        id: -2,
        title: _meals[1]['name'].toString(),
        body: _meals[1]['notes'].toString(),
        hour: _meal2Time.hour,
        minute: _meal2Time.minute,
        fln: flnp);
    noti.showBigTextNotification(
        id: -1,
        title: _meals[2]['name'].toString(),
        body: _meals[2]['notes'].toString(),
        hour: _meal3Time.hour,
        minute: _meal3Time.minute,
        fln: flnp);
    saveEvents('meals', _mealsString);

    _load = true;
  }

  Future<bool> getEvents() async {
    var sp = await SharedPreferences.getInstance();
    if (sp.getString('sleep') != null) {
      var data = await json.decode(sp.getString('sleep') ?? "");
      String temp = data['time'];
      _sleepTime = TimeOfDay(
        hour: int.parse(temp.split(':')[0]),
        minute: int.parse(temp.split(':')[1]),
      );
      _sleepNotes = data['notes'];
      _sleepName = data['name'];
      noti.showBigTextNotification(
          id: -4,
          title: _sleepName,
          body: _sleepNotes,
          hour: _sleepTime.hour,
          minute: _sleepTime.minute,
          fln: flnp);
    }

    if (sp.getString('wake') != null) {
      var data = await json.decode(sp.getString('wake') ?? "");
      String temp = data['time'];
      _wakeTime = TimeOfDay(
          hour: int.parse(temp.split(':')[0]),
          minute: int.parse(temp.split(':')[1]));
      _wakeNotes = data['notes'];
      _wakename = data['name'];
      noti.showBigTextNotification(
          id: -5,
          title: _wakename,
          body: _wakeNotes,
          hour: _wakeTime.hour,
          minute: _wakeTime.minute,
          fln: flnp);
    }
    if (sp.getString('meals') != null) {
      var temp = await json.decode(sp.getString('meals') ?? "");
      _meal1Time = TimeOfDay(
          hour: int.parse(temp[0]['meal'].split(':')[0]),
          minute: int.parse(temp[0]['meal'].split(':')[1]));
      _meal2Time = TimeOfDay(
          hour: int.parse(temp[1]['meal'].split(':')[0]),
          minute: int.parse(temp[1]['meal'].split(':')[1]));
      _meal3Time = TimeOfDay(
          hour: int.parse(temp[2]['meal'].split(':')[0]),
          minute: int.parse(temp[2]['meal'].split(':')[1]));
      _meals[0]['meal'] = _meal1Time;
      _meals[1]['meal'] = _meal2Time;
      _meals[2]['meal'] = _meal3Time;
      _meals[0]['notes'] = temp[0]['notes'];
      _meals[1]['notes'] = temp[1]['notes'];
      _meals[2]['notes'] = temp[2]['notes'];
      _meals[0]['name'] = temp[0]['name'];
      _meals[1]['name'] = temp[1]['name'];
      _meals[2]['name'] = temp[2]['name'];
      noti.showBigTextNotification(
          id: -3,
          title: _meals[0]['name'].toString(),
          body: _meals[0]['notes'].toString(),
          hour: _meal1Time.hour,
          minute: _meal1Time.minute,
          fln: flnp);
      noti.showBigTextNotification(
          id: -2,
          title: _meals[1]['name'].toString(),
          body: _meals[1]['notes'].toString(),
          hour: _meal2Time.hour,
          minute: _meal2Time.minute,
          fln: flnp);
      noti.showBigTextNotification(
          id: -1,
          title: _meals[2]['name'].toString(),
          body: _meals[2]['notes'].toString(),
          hour: _meal3Time.hour,
          minute: _meal3Time.minute,
          fln: flnp);
      print("build");
    }
    if (sp.getString('med') != null) {
      var temp = await json.decode(sp.getString('med') ?? "");
      for (var _med in temp) {
        var _med1 = {
          'name': _med['name'],
          'time': null,
          'notes': _med['notes'],
          'id': _med['id']
        };
        _med1['time'] = TimeOfDay(
            hour: int.parse(_med['time'].split(':')[0]),
            minute: int.parse(_med['time'].split(':')[1]));
        _medicens.add(_med1);
        noti.showBigTextNotification(
            id: int.parse(_med1['id'].toString()),
            title: _med1['name'].toString(),
            body: _med1['notes'].toString(),
            hour: _med1['time'].hour,
            minute: _med1['time'].minute,
            fln: flnp);
      }
    }
    print("end");
    if (sp.getString('sleep') != null) {
      _load = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void newEvent(name, times, notes, food, context, _formkey, {time}) {
    if (!_formkey.currentState!.validate()) {
      return;
    } else {
      FocusScope.of(context).unfocus();
      if (times == "once") {
        DateTime dateTime;
        var duration;
        var _time;
        if (food == 'none') {
          dateTime = DateTime(2023, 1, 1, _wakeTime.hour, _wakeTime.minute);
          duration = dateTime.add(Duration(hours: 5));
        } else {
          dateTime = DateTime(2023, 1, 1, _meal1Time.hour, _meal1Time.minute);
          if (food == 'after')
            duration = dateTime.add(Duration(hours: int.parse(time)));
          else if (food == 'before') {
            duration = dateTime.subtract(Duration(hours: int.parse(time)));
          }
        }
        _time = TimeOfDay.fromDateTime(duration);
        var med1 = {
          'name': name,
          'time': _time,
          'notes': notes,
          'id': _medicens.length
        };
        print(_medicens.length);

        _medicens.add(med1);
        noti.showBigTextNotification(
            id: int.parse(med1['id'].toString()),
            title: med1['name'].toString(),
            body: med1['notes'].toString(),
            hour: med1['time'].hour,
            minute: med1['time'].minute,
            fln: flnp);
      } else if (times == "twice") {
        var _time1;
        var _time2;
        if (food == 'none') {
          DateTime dateTime1 =
              DateTime(2023, 1, 1, _wakeTime.hour, _wakeTime.minute);

          _time2 = dateTime1.add(Duration(hours: 1));
          _time1 = dateTime1.add(Duration(hours: 13));
        } else {
          DateTime dateTime1 =
              DateTime(2023, 1, 1, _meal1Time.hour, _meal1Time.minute);
          DateTime dateTime2 =
              DateTime(2023, 1, 1, _meal3Time.hour, _meal3Time.minute);
          if (food == 'after') {
            _time1 = dateTime1.add(Duration(hours: int.parse(time)));
            _time2 = dateTime2.add(Duration(hours: int.parse(time)));
          } else if (food == 'before') {
            _time1 = dateTime1.subtract(Duration(hours: int.parse(time)));
            _time2 = dateTime2.subtract(Duration(hours: int.parse(time)));
          }
        }
        var med1 = {
          'name': name,
          'time': TimeOfDay.fromDateTime(_time1),
          'notes': notes,
          'id': _medicens.length
        };
        print(_medicens.length);

        _medicens.add(med1);
        noti.showBigTextNotification(
            id: int.parse(med1['id'].toString()),
            title: med1['name'].toString(),
            body: med1['notes'].toString(),
            hour: med1['time'].hour,
            minute: med1['time'].minute,
            fln: flnp);
        var med2 = {
          'name': name,
          'time': TimeOfDay.fromDateTime(_time2),
          'notes': notes,
          'id': _medicens.length
        };
        print(_medicens.length);

        _medicens.add(med2);
        noti.showBigTextNotification(
            id: int.parse(med2['id'].toString()),
            title: med2['name'].toString(),
            body: med2['notes'].toString(),
            hour: med2['time'].hour,
            minute: med2['time'].minute,
            fln: flnp);
      } else {
        var _time1;
        var _time2;
        var _time3;
        if (food == 'none') {
          DateTime dateTime1 =
              DateTime(2023, 1, 1, _wakeTime.hour, _wakeTime.minute);
          DateTime duration1 = dateTime1.add(Duration(hours: 1));
          _time1 = TimeOfDay.fromDateTime(duration1);
          DateTime duration2 = dateTime1.add(Duration(hours: 9));
          _time2 = TimeOfDay.fromDateTime(duration2);
          DateTime duration3 = dateTime1.add(Duration(hours: 17));
          _time3 = TimeOfDay.fromDateTime(duration3);
        } else {
          DateTime dateTime1 =
              DateTime(2023, 1, 1, _meal1Time.hour, _meal1Time.minute);
          DateTime dateTime2 =
              DateTime(2023, 1, 1, _meal2Time.hour, _meal2Time.minute);
          DateTime dateTime3 =
              DateTime(2023, 1, 1, _meal3Time.hour, _meal3Time.minute);
          if (food == 'after') {
            _time1 = dateTime1.add(Duration(hours: int.parse(time)));
            _time2 = dateTime2.add(Duration(hours: int.parse(time)));
            _time3 = dateTime3.add(Duration(hours: int.parse(time)));
          } else if (food == 'before') {
            _time1 = dateTime1.subtract(Duration(hours: int.parse(time)));
            _time2 = dateTime2.subtract(Duration(hours: int.parse(time)));
            _time3 = dateTime3.subtract(Duration(hours: int.parse(time)));
          }
          var med1 = {
            'name': name,
            'time': TimeOfDay.fromDateTime(_time1),
            'notes': notes,
            'id': _medicens.length
          };
          print(_medicens.length);

          _medicens.add(med1);
          noti.showBigTextNotification(
              id: int.parse(med1['id'].toString()),
              title: med1['name'].toString(),
              body: med1['notes'].toString(),
              hour: med1['time'].hour,
              minute: med1['time'].minute,
              fln: flnp);
          var med2 = {
            'name': name,
            'time': TimeOfDay.fromDateTime(_time2),
            'notes': notes,
            'id': _medicens.length
          };
          print(_medicens.length);

          _medicens.add(med2);
          noti.showBigTextNotification(
              id: int.parse(med2['id'].toString()),
              title: med2['name'].toString(),
              body: med2['notes'].toString(),
              hour: med2['time'].hour,
              minute: med2['time'].minute,
              fln: flnp);
          var med3 = {
            'name': name,
            'time': TimeOfDay.fromDateTime(_time3),
            'notes': notes,
            'id': _medicens.length
          };
          print(_medicens.length);

          _medicens.add(med3);
          noti.showBigTextNotification(
              id: int.parse(med3['id'].toString()),
              title: med3['name'].toString(),
              body: med3['notes'].toString(),
              hour: med3['time'].hour,
              minute: med3['time'].minute,
              fln: flnp);
        }
      }

      var _meds = [];
      for (int i = 0; i < _medicens.length; i++) {
        var _med1 = {
          'name': _medicens[i]['name'],
          'time': '',
          'notes': _medicens[i]['notes'],
          'id': _medicens[i]['id']
        };
        _med1['time'] = _medicens[i]['time'].hour.toString() +
            ":" +
            _medicens[i]['time'].minute.toString();
        _meds.add(_med1);
      }
      saveEvents('med', _meds);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => dayAlarms()),
          (Route<dynamic> route) => false);
    }
  }

  void editEvent(type, id, name, time, notes, context) {
    if (type == 'med') {
      print(id);
      print(_medicens.length);
      _medicens[id]['name'] = name;
      _medicens[id]['time'] = time;
      _medicens[id]['notes'] = notes;
      var _meds = [];
      for (int i = 0; i < _medicens.length; i++) {
        var _med1 = {
          'name': _medicens[i]['name'],
          'time': '',
          'notes': _medicens[i]['notes'],
          'id': i
        };
        _med1['time'] = _medicens[i]['time'].hour.toString() +
            ":" +
            _medicens[i]['time'].minute.toString();
        _meds.add(_med1);
        noti.showBigTextNotification(
            id: int.parse(_med1['id'].toString()),
            title: _med1['name'],
            body: _med1['notes'],
            hour: _medicens[i]['time'].hour,
            minute: _medicens[i]['time'].minute,
            fln: flnp);
      }
      saveEvents('med', _meds);

      print(_medicens.length);
    } else if (type == 'meal') {
      _meals[id]['name'] = name;
      _meals[id]['meal'] = time;
      _meals[id]['notes'] = notes;
      if (id == 0) {
        _meal1Time = time;
        noti.showBigTextNotification(
            id: -3,
            title: name,
            body: notes,
            hour: time.hour,
            minute: time.minute,
            fln: flnp);
      } else if (id == 1) {
        _meal2Time = time;
        noti.showBigTextNotification(
            id: -2,
            title: name,
            body: notes,
            hour: time.hour,
            minute: time.minute,
            fln: flnp);
      } else {
        _meal3Time = time;
        noti.showBigTextNotification(
            id: -1,
            title: name,
            body: notes,
            hour: time.hour,
            minute: time.minute,
            fln: flnp);
      }
      var _mealsString = [
        {
          'name': _meals[0]['name'],
          'meal':
              _meal1Time.hour.toString() + ":" + _meal1Time.minute.toString(),
          'notes': _meals[0]['notes']
        },
        {
          'name': _meals[1]['name'],
          'meal':
              _meal2Time.hour.toString() + ":" + _meal2Time.minute.toString(),
          'notes': _meals[1]['notes']
        },
        {
          'name': _meals[2]['name'],
          'meal':
              _meal3Time.hour.toString() + ":" + _meal3Time.minute.toString(),
          'notes': _meals[2]['notes']
        }
      ];
      saveEvents('meals', _mealsString);
    } else {
      if (id == 0) {
        _sleepTime = time;
        _sleepNotes = notes;
        _sleepName = name;
        saveEvents('sleep', {
          'name': _sleepName,
          'time':
              _sleepTime.hour.toString() + ":" + _sleepTime.minute.toString(),
          'notes': _sleepNotes
        });
        noti.showBigTextNotification(
            id: -4,
            title: name,
            body: notes,
            hour: time.hour,
            minute: time.minute,
            fln: flnp);
        print(_sleepNotes);
      } else {
        _wakeTime = time;
        _wakeNotes = notes;
        _wakename = name;
        saveEvents('wake', {
          'name': _wakename,
          'time': _wakeTime.hour.toString() + ":" + _wakeTime.minute.toString(),
          'notes': _wakeNotes
        });
        noti.showBigTextNotification(
            id: -5,
            title: name,
            body: notes,
            hour: time.hour,
            minute: time.minute,
            fln: flnp);
      }
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => dayAlarms()),
        (Route<dynamic> route) => false);
  }

  void deleteEvent(id, context) {
    _medicens.removeAt(id);
    var _meds = [];
    for (int i = 0; i < _medicens.length; i++) {
      var _med1 = {
        'name': _medicens[i]['name'],
        'time': '',
        'notes': _medicens[i]['notes'],
        'id': i
      };
      _med1['time'] = _medicens[i]['time'].hour.toString() +
          ":" +
          _medicens[i]['time'].minute.toString();
      _medicens[i]['id'] = i;
      noti.showBigTextNotification(
          id: i,
          title: _med1['name'],
          body: _med1['notes'],
          hour: _medicens[i]['time'].hour,
          minute: _medicens[i]['time'].minute,
          fln: flnp);
      _meds.add(_med1);
    }
    flnp.cancel(_medicens.length);
    saveEvents('med', _meds);
    Navigator.of(context).pushReplacementNamed(dayAlarms.routeName);
  }
}
