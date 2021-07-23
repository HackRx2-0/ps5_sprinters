import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'storage_constants.dart';

class Storage {
  final storage = new FlutterSecureStorage();

  Future<void> setSpeechLanguageToHindi() async {
    await storage.write(key: LANGUAGE_KEY, value: HINDI_LANGUAGE);
  }

  Future<void> setSpeechLanguageToEnglish() async {
    await storage.write(key: LANGUAGE_KEY, value: ENGLISH_LANGUAGE);
  }

  Future<String> retrieveSpeechLanguage() async {
    String? value = await storage.read(key: LANGUAGE_KEY);
    return value != null ? value : ENGLISH_LANGUAGE;
  }

  Future<void> setTextToSpeechOn() async {
    await storage.write(
        key: TEXT_TO_SPEECH_PREFERENCE_KEY, value: TEXT_TO_SPEECH_ON);
  }

  Future<void> setTextToSpeechOff() async {
    await storage.write(
        key: TEXT_TO_SPEECH_PREFERENCE_KEY, value: TEXT_TO_SPEECH_OFF);
  }

  Future<String> retrieveTextToSpeechStatus() async {
    String? value = await storage.read(key: TEXT_TO_SPEECH_PREFERENCE_KEY);
    return value != null ? value : TEXT_TO_SPEECH_ON;
  }
}
