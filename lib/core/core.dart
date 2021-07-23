import 'package:voice_notification_app/speech/speech_utils.dart';
import 'package:voice_notification_app/storage/database/data/notification.dart';
import 'package:voice_notification_app/storage/database/database.dart';
import 'package:voice_notification_app/storage/storage.dart';
import 'package:voice_notification_app/storage/storage_constants.dart';
import 'package:voice_notification_app/translation/translation_utils.dart';

class Core {
  static Future<void> notificationHandler(String? title, String? body) async {
    await NotifDatabaseProvider.db
        .addNotifToDatabase(new Notif(payload: body!));
    Storage storage = Storage();
    String textToSpeechPreference = await storage.retrieveTextToSpeechStatus();

    if (textToSpeechPreference == TEXT_TO_SPEECH_ON) {
      String notificationText = "Message from $title. $body";
      String translateToLanguageCode =
          await TranslationUtils.retrieveLanguageCode();
      String speechLanguageCode = await SpeechUtils.retrieveLanguageCode();
      String translatedText = await TranslationUtils.translateToLanguage(
          notificationText, translateToLanguageCode);
      await SpeechUtils.textToSpeech(translatedText, speechLanguageCode);
    }
  }
}
