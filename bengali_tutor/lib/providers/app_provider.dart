// lib/providers/app_provider.dart
import 'package:flutter/foundation.dart';
import '../models/content_models.dart';
import '../services/progress_service.dart';
import '../services/tts_service.dart';
import '../data/content_data.dart';

class AppProvider with ChangeNotifier {
  final ProgressService _progressService;
  final TtsService _ttsService;

  AppProvider(this._progressService, this._ttsService);

  List<Topic> get allTopics => topics;
  List<Scenario> get allScenarios => scenarios;

  // Progress
  bool isTopicCompleted(String id) => _progressService.isTopicCompleted(id);
  bool isScenarioCompleted(String id) => _progressService.isScenarioCompleted(id);
  
  double get totalProgress {
    int totalItems = topics.length + scenarios.length;
    if (totalItems == 0) return 0.0;
    return _progressService.totalCompleted / totalItems;
  }

  Future<void> completeTopic(String id) async {
    await _progressService.markTopicComplete(id);
    notifyListeners();
  }

  Future<void> completeScenario(String id) async {
    await _progressService.markScenarioComplete(id);
    notifyListeners();
  }

  // TTS
  Future<void> speak(String text) async {
    await _ttsService.speak(text);
  }
}
