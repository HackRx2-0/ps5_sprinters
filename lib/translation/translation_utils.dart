import 'package:translator/translator.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';

class TranslationUtils {
  static Future<String> translateToLanguage(
      String text, String languageCode) async {
    final translator = GoogleTranslator();
    var translatedObj = await translator.translate(text, to: languageCode);
    return translatedObj.text;
  }

  static Future<String> retrieveLanguageCode() async {
    Storage storage = Storage();
    String language = await storage.retrieveSpeechLanguage();
    if (language == HINDI_LANGUAGE) {
      return "hi";
    } else {
      return "en";
    }
  }
}
