import 'package:translator/translator.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';

class TranslationUtils {
  static const Map<String, String> languageMap = {
    ENGLISH_LANGUAGE: 'en',
    HINDI_LANGUAGE: 'hi',
    BENGALI_LANGUAGE: 'bn',
    TAMIL_LANGUAGE: 'ta',
    TELUGU_LANGUAGE: 'te'
  };

  static Future<String> translateToLanguage(
      String text, String languageCode) async {
    final translator = GoogleTranslator();
    var translatedObj = await translator.translate(text, to: languageCode);
    return translatedObj.text;
  }

  static Future<String> retrieveLanguageCode() async {
    Storage storage = Storage();
    String language = await storage.retrieveSpeechLanguage();
    return languageMap[language]!;
  }
}
