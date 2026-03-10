import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import '../models/content_models.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();

  AudioService() {
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("bn-BD");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> playPhrase(Phrase phrase, {bool slow = false}) async {
    await stop(); // Stop any previous playback

    // 1. Determine target file name
    final String? fileName = slow
        ? phrase.audioPathSlow
        : phrase.audioPathNatural;

    if (fileName != null) {
      // 2. Check if file exists in documents directory (Recorded by user)
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final File localFile = File('${appDocDir.path}/$fileName');

      if (await localFile.exists()) {
        await _audioPlayer.play(DeviceFileSource(localFile.path));
        return;
      }

      // 3. Future: Check assets
      // try {
      //    await _audioPlayer.play(AssetSource('audio/$fileName'));
      //    return;
      // } catch (e) {}
    }

    // 4. Fallback to TTS
    await _flutterTts.setSpeechRate(slow ? 0.3 : 0.5);
    await _flutterTts.speak(phrase.bengaliScript);
  }

  Future<void> playWord(Word word) async {
    await stop();
    final String? fileName = word.audioPath;
    if (fileName != null) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final File localFile = File('${appDocDir.path}/$fileName');
      if (await localFile.exists()) {
        await _audioPlayer.play(DeviceFileSource(localFile.path));
        return;
      }
    }
    // Fallback
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.speak(word.bengaliScript);
  }

  Future<void> playScript(String script) async {
    await stop();
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(script);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _flutterTts.stop();
  }
}
