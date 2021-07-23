import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:voice_notification_app/core/core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';
import 'package:toggle_switch/toggle_switch.dart';
import './list_notifications.dart';

const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('test_id', 'test_name', 'test_description',
        importance: Importance.max, priority: Priority.high);
const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const Map<String, String> languageMap = {
  ENGLISH_LANGUAGE: 'English',
  HINDI_LANGUAGE: 'Hindi',
  BENGALI_LANGUAGE: 'Bengali',
  TAMIL_LANGUAGE: 'Tamil',
  TELUGU_LANGUAGE: 'Telugu'
};

class SettingsOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";

  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  late bool _dark;
  String _chosenValue = 'English';

  void triggerTestNotification() async {
    String title = 'Bajaj Finserv';
    String body = 'Your Wallet credited with 100 rupees';
    await Core.notificationHandler(title, body);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  @override
  void initState() {
    super.initState();
    initDefaultValues();
    _dark = false;
  }

  int initAudioPrefIndex = 0;
  int initAudioLanguageIndex = 0;

  Future<void> initDefaultValues() async {
    String textToSpeechPreference =
        await Storage().retrieveTextToSpeechStatus();
    initAudioPrefIndex = textToSpeechPreference == TEXT_TO_SPEECH_ON ? 0 : 1;

    String audioLanguage = await Storage().retrieveSpeechLanguage();
    _chosenValue = languageMap[audioLanguage]!;

    setState(() {
      initAudioLanguageIndex = initAudioLanguageIndex;
      _chosenValue = _chosenValue;
    });
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    print("ihdhihdi");
    return Theme(
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.moon),
              onPressed: () {
                setState(() {
                  _dark = !_dark;
                });
              },
            )
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.blue[800],
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        "Vishu Saxena",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80'),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.blue[700],
                          ),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.language,
                            color: Colors.blue[700],
                          ),
                          title: Text("Change Language"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change language
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.blue[700],
                          ),
                          title: Text("Change Location"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 20.0),
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
                              initAudioPrefIndex = 1;
                              await Storage().setTextToSpeechOff();
                            } else {
                              initAudioPrefIndex = 0;
                              await Storage().setTextToSpeechOn();
                            }
                          },
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Choose language'),
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        child: DropdownButton<String>(
                          value: _chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            'English',
                            'Hindi',
                            'Bengali',
                            'Tamil',
                            'Telugu',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(
                              () {
                                _chosenValue = value!;
                              },
                            );

                            if (value == 'English') {
                              Storage().setSpeechLanguageToEnglish();
                            } else if (value == 'Hindi') {
                              Storage().setSpeechLanguageToHindi();
                            } else if (value == 'Bengali') {
                              Storage().setSpeechLanguageToBengali();
                            } else if (value == 'Tamil') {
                              Storage().setSpeechLanguageToTamil();
                            } else {
                              Storage().setSpeechLanguageToTelugu();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: InkWell(
                        onTap: triggerTestNotification,
                        child: Text(
                          'Trigger test notification',
                          style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
            Positioned(
              bottom: -20,
              left: -20,
              child: Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 00,
              left: 00,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.bell,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListNotifications(),
                    ),
                  );
                  //log out
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
