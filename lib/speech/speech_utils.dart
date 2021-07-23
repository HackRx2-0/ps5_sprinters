import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../helper/checkSafeString.dart';

void _onResultListener(
    SpeechRecognitionResult result, String text, FlutterTts flutterTts) async {
  print('run2');
  String lastWords = '${result.recognizedWords}';
  if (lastWords == 'yes') {
    await flutterTts.speak(text);
  }
  print(lastWords);
}

class SpeechUtils {
  static Future<void> textToSpeech(String text, String languageCode) async {
    var microphoneStatus = await Permission.microphone.status;
    if (!microphoneStatus.isGranted) await Permission.microphone.request();
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(languageCode);
    bool isSafe = !checkSafeString(text);
    print(isSafe);
    if (isSafe) {
      await flutterTts.speak(text);
    } else {
      stt.SpeechToText speech = stt.SpeechToText();
      bool available = await speech.initialize();
      if (available) {
        speech.listen(
            onResult: (SpeechRecognitionResult result) =>
                _onResultListener(result, text, flutterTts));
      } else {
        print("The user has denied the use of speech recognition.");
      }
      Future.delayed(
        Duration(seconds: 10),
        () {
          speech.stop();
        },
      );
    }
  }

  static Future<String> retrieveLanguageCode() async {
    Storage storage = Storage();
    String language = await storage.retrieveSpeechLanguage();
    if (language == HINDI_LANGUAGE) {
      return "hi-IN";
    } else {
      return "en-Us";
    }
  }
}
