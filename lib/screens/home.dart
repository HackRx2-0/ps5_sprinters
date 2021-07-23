import 'package:flutter/material.dart';
import 'package:voice_notification_app/core/core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';
import 'package:voice_notification_app/screens/list_notifications.dart';
import 'package:toggle_switch/toggle_switch.dart';

const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('test_id', 'test_name', 'test_description',
        importance: Importance.max, priority: Priority.high);
const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void triggerTestNotification() async {
    String title = 'Bajaj Finserv';
    String body = 'Your Wallet has been credited with 1000 Rupees';
    await Core.notificationHandler(title, body);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      String? title = message.notification!.title;
      String? body = message.notification!.body;
      await Core.notificationHandler(title, body);
    });

    initDefaultValues();

    super.initState();
  }

  int initAudioPrefIndex = 0;
  int initAudioLanguageIndex = 0;

  Future<void> initDefaultValues() async {
    String textToSpeechPreference =
        await Storage().retrieveTextToSpeechStatus();
    initAudioPrefIndex = textToSpeechPreference == TEXT_TO_SPEECH_ON ? 0 : 1;

    String audioLanguage = await Storage().retrieveSpeechLanguage();
    initAudioLanguageIndex = audioLanguage == ENGLISH_LANGUAGE ? 0 : 1;
    setState(() {
      initAudioLanguageIndex = initAudioLanguageIndex;
      initAudioPrefIndex = initAudioPrefIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.notifications),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ListNotifications()));
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set text to speech:',
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: 30.0,
                child: ToggleSwitch(
                  cornerRadius: 5.0,
                  activeBgColor: [Colors.black],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[200],
                  inactiveFgColor: Colors.grey[900],
                  initialLabelIndex: initAudioPrefIndex,
                  totalSwitches: 2,
                  animate: true,
                  curve: Curves.linear,
                  labels: ['ON', 'OFF'],
                  onToggle: (index) async {
                    if (index == 1) {
                      await Storage().setTextToSpeechOff();
                    } else {
                      await Storage().setTextToSpeechOn();
                    }
                  },
                ),
              ),
            ],
          )),
          SizedBox(
            height: 40.0,
          ),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Audio Language:',
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: 30.0,
                child: ToggleSwitch(
                  cornerRadius: 5.0,
                  activeBgColor: [Colors.black],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[200],
                  inactiveFgColor: Colors.grey[900],
                  initialLabelIndex: initAudioLanguageIndex,
                  totalSwitches: 2,
                  animate: true,
                  curve: Curves.linear,
                  labels: ['English', 'Hindi'],
                  onToggle: (index) async {
                    if (index == 1) {
                      await Storage().setSpeechLanguageToHindi();
                    } else {
                      await Storage().setSpeechLanguageToEnglish();
                    }
                  },
                ),
              ),
            ],
          )),
          SizedBox(
            height: 40.0,
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.black,
                  textStyle: TextStyle(fontSize: 15)),
              onPressed: triggerTestNotification,
              child: Text('TRIGGER TEST NOTIFICATION'),
            ),
          )
        ],
      ),
    );
  }
}
