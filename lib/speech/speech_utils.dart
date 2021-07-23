import 'package:flutter_tts/flutter_tts.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';

class SpeechUtils {
  static const Map<String, String> languageMap = {
    ENGLISH_LANGUAGE: 'en',
    HINDI_LANGUAGE: 'hi',
    BENGALI_LANGUAGE: 'bn',
    TAMIL_LANGUAGE: 'ta',
    TELUGU_LANGUAGE: 'te'
  };

  static Future<void> textToSpeech(String text, String languageCode) async {
    FlutterTts flutterTts = FlutterTts();
    print(flutterTts.getLanguages.toString());
    await flutterTts.setLanguage(languageCode);
    await flutterTts.speak(text);
  }

  static Future<String> retrieveLanguageCode() async {
    Storage storage = Storage();
    String language = await storage.retrieveSpeechLanguage();
    return languageMap[language]!;
  }
}