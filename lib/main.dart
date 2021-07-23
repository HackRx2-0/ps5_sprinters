import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:voice_notification_app/core/core.dart';
import 'package:voice_notification_app/test_notification/notification_service.dart';

import './widgets/app_drawer.dart';
import './screens/splash_screen.dart';
import './screens/home_page.dart';
import './screens/settings.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  await Core.notificationHandler(title, body);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationService().init();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  print('run');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool splashScreen = true;

  void popSplashScreen(BuildContext context) async {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        splashScreen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (splashScreen) {
      popSplashScreen(context);
    }
    print('run');
    return MaterialApp(
      title: 'Bajaj Finserv',
      debugShowCheckedModeBanner: false,
      home: splashScreen
          ? SplashScreen()
          : Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text('BAJAJ Finserv'),
                backgroundColor: Colors.blue[800],
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(
                      Icons.menu,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.shop),
                    ),
                  ),
                ],
              ),
              drawer: AppDrawer(),
              body: HomePage(),
            ),
    );
  }
}
