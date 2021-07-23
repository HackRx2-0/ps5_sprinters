import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:voice_notification_app/core/core.dart';
import 'package:voice_notification_app/screens/list_notifications.dart';
import 'package:voice_notification_app/test_notification/notification_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import './widgets/app_drawer.dart';
import './screens/splash_screen.dart';

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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late WebViewController _myController;
  bool isLoading = true;
  bool splashScreen = true;
  final _key = UniqueKey();

  void popSplashScreen() {
    Timer(Duration(seconds: 5), () {
      setState(() {
        splashScreen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    popSplashScreen();
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
                    bottom: Radius.circular(10),
                  ),
                ),
                actions: [
                  Icon(Icons.notifications),
                  Icon(Icons.more_vert),
                  InkWell(
                    child: Icon(Icons.notifications),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListNotifications()),
                      );
                    },
                  )
                ],
              ),
              drawer: AppDrawer(),
              body: Stack(
                children: [
                  WebView(
                    key: _key,
                    initialUrl: "https://www.bajajfinserv.in/",
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                      _myController = webViewController;
                    },
                    onPageFinished: (String url) {
                      print('Loaded');
                      setState(() {
                        isLoading = false;
                      });
                      print('Page finished loading: $url');
                      _myController.evaluateJavascript(
                          "document.getElementsByClassName(\"navbar\")[0].style.display='none';");
                    },
                  ),
                  isLoading
                      ? Center(
                          child: SpinKitPulse(
                            color: Colors.blue[900],
                            size: 70,
                          ),
                        )
                      : Stack(),
                ],
              ),
            ),
    );
  }
}
