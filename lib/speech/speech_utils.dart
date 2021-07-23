import 'package:flutter_tts/flutter_tts.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';

class SpeechUtils {
  static Future<void> textToSpeech(String text, String languageCode) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(languageCode);
    await flutterTts.speak(text);
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
