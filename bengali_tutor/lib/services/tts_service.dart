// lib/services/tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    _initTts();
  }

  Future<void> _initTts() async {
    // Attempt to set Bengali language
    // 'bn-BD' (Bangladesh) is preferred for Dhaka dialect, 'bn-IN' (Kolkata) is a fallback
    try {
      await _flutterTts.setLanguage("bn-BD");
    } catch (e) {
      try {
        await _flutterTts.setLanguage("bn-IN");
      } catch (e) {
        print("TTS Error: Bengali language not supported on this device.");
      }
    }
    
    await _flutterTts.setSpeechRate(0.1); // Slower rate for beginners
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await _flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
