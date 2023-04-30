import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:wakewell/provider/provider.dart';
import 'package:wakewell/screens/dayAlarms.dart';
import 'package:wakewell/screens/edit.dart';
import 'package:wakewell/screens/newEvent.dart';
import 'provider/provider.dart';
import 'screens/homepage.dart';
import 'provider/notifications.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

final fontSize = 0.05;

final FlutterLocalNotificationsPlugin flnp =
    new FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /* noti.initialize(flnp);*/

  runApp(
    WakeWell(),
  );
}

class WakeWell extends StatefulWidget {
  @override
  State<WakeWell> createState() => _WakeWellState();
}

class _WakeWellState extends State<WakeWell> {
  VideoPlayerController _controller =
      VideoPlayerController.asset("assets/IMG_9977.MP4");
  checkVideo() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        _showVideo = false;
      });
    }
  }

  bool load = false;
  bool _showVideo = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    noti.initialize(flnp);
    _checkFirstTime();
    _controller.addListener(checkVideo);
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time') ?? true;

    if (firstTime) {
      await prefs.setBool('first_time', false);
      _showVideo = true;
      _controller
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    }
    setState(() {
      load = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    setState(() {
      _showVideo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_showVideo);
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
                child: load
                    ? _showVideo
                        ? Scaffold(
                            body: Stack(
                            children: <Widget>[
                              VideoPlayer(_controller),
                              Positioned.fill(
                                child: InkWell(
                                  onTap: () {
                                    _controller.pause();
                                    setState(() {
                                      _showVideo = false;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ],
                          ))
                        : auth.load
                            ? dayAlarms()
                            : FutureBuilder(
                                future: auth.getEvents(),
                                builder: (ctx, AsyncSnapshot authsnapshot) =>
                                    authsnapshot.connectionState ==
                                            ConnectionState.waiting
                                        ? const CircularProgressIndicator()
                                        : const home())
                    : Scaffold(
                        body: CircularProgressIndicator(),
                      ))),
      ),
    );
  }
}
