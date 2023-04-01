import 'package:flutter_tts/flutter_tts.dart';

class TTS {
  String text;
  String repeattext;
  String repeattext3;

  TTS(
      {required this.text,
      required this.repeattext,
      required this.repeattext3});
  FlutterTts flutterTts = FlutterTts();

  pause() {
    flutterTts.pause();
  }

  speak() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setEngine("com.google.android.tts");
    await flutterTts.setLanguage("ar");
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(.5);
    await flutterTts.setPitch(.9);
    await flutterTts.speak(text);
    Future.delayed(const Duration(milliseconds: 2000));
    await flutterTts.speak("$repeattext");
    Future.delayed(const Duration(milliseconds: 1000));
    await flutterTts.speak("$repeattext3");
  }
}
