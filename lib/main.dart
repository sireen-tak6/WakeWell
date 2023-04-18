import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/provider/provider.dart';
import 'package:wakewell/screens/dayAlarms.dart';
import 'package:wakewell/screens/edit.dart';
import 'package:wakewell/screens/newEvent.dart';
import 'provider/provider.dart';
import 'screens/homepage.dart';
import 'provider/notifications.dart';

final FlutterLocalNotificationsPlugin flnp =
    new FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  noti.initialize(flnp);

  runApp(
    WakeWell(),
  );
}

class WakeWell extends StatefulWidget {
  @override
  State<WakeWell> createState() => _WakeWellState();
}

class _WakeWellState extends State<WakeWell> {
  bool _isloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noti.initialize(flnp);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: auth()),
      ],
      child: Consumer<auth>(
        // ignore: avoid_types_as_parameter_names
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 92, 104, 83)),
            primaryColorLight: Color.fromARGB(255, 92, 104, 83),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            dayAlarms.routeName: (context) => dayAlarms(),
            newEvent.routeName: (context) => newEvent(),
            editEvent.routename: (context) => editEvent(),
          },
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: auth.load
                ? dayAlarms()
                : FutureBuilder(
                    future: auth.getEvents(),
                    builder: (ctx, AsyncSnapshot authsnapshot) =>
                        authsnapshot.connectionState == ConnectionState.waiting
                            ? CircularProgressIndicator()
                            : const home()),
          ),
        ),
      ),
    );
  }
}
