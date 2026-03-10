import 'package:flutter/foundation.dart';
import '../models/content_models.dart';
import '../services/progress_service.dart';
import '../services/content_service.dart';
import '../services/audio_service.dart';
import 'dart:math';

import '../data/scenario_data.dart';

class AppProvider with ChangeNotifier {
  final ProgressService _progressService;
  final ContentService _contentService = ContentService();
  final AudioService _audioService = AudioService();

  List<Level> _levels = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Scenario> get allScenarios => scenarios;

  AppProvider(this._progressService) {
    _loadContent();
  }

  List<Level> get levels => _levels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AudioService get audioService => _audioService;

  Future<void> _loadContent() async {
    try {
      _isLoading = true;
      notifyListeners();

      _levels = await _contentService.loadLevels();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load content: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Progress
  bool isUnitCompleted(String id) => _progressService.isTopicCompleted(id);

  Future<void> completeUnit(String id) async {
    await _progressService.markTopicComplete(id);
    notifyListeners();
  }

  bool isScenarioCompleted(String id) =>
      _progressService.isScenarioCompleted(id);

  Future<void> completeScenario(String id) async {
    await _progressService.markScenarioComplete(id);
    notifyListeners();
  }

  // Unit Locking Logic
  Unit? get nextPlayableUnit {
    if (_levels.isEmpty) return null;

    // Iterate through all units to find the first incomplete one
    for (var level in _levels) {
      for (var unit in level.units) {
        if (!isUnitCompleted(unit.id)) {
          return unit;
        }
      }
    }
    return null;
  }

  bool isUnitLocked(String unitId) {
    bool previousCompleted = true; // First unit is always unlocked

    for (var level in _levels) {
      for (var unit in level.units) {
        if (unit.id == unitId) {
          return !previousCompleted;
        }
        previousCompleted = isUnitCompleted(unit.id);
      }
    }
    return true; // Should not happen if ID exists
  }

  // Practice Session Logic
  List<Phrase> generatePracticeSession(Unit currentUnit) {
    List<Phrase> sessionPhrases = [];

    // 1. Add all phrases from current unit
    sessionPhrases.addAll(currentUnit.phrases);

    // 2. Add random review phrases from previous units (Spiral Learning)
    final reviewPhrases = _getReviewPhrases(currentUnit.id);
    sessionPhrases.addAll(reviewPhrases);

    // 3. Shuffle
    sessionPhrases.shuffle(Random());

    return sessionPhrases;
  }

  List<Phrase> _getReviewPhrases(String currentUnitId) {
    List<Phrase> availableForReview = [];

    for (var level in _levels) {
      for (var unit in level.units) {
        if (unit.id == currentUnitId) return _pickRandom(availableForReview, 3);

        if (isUnitCompleted(unit.id)) {
          availableForReview.addAll(unit.phrases);
        }
      }
    }
    return _pickRandom(availableForReview, 3);
  }

  List<Phrase> _pickRandom(List<Phrase> source, int count) {
    if (source.isEmpty) return [];
    source.shuffle();
    return source.take(count).toList();
  }

  // Audio Proxy
  Future<void> playPhrase(Phrase phrase, {bool slow = false}) async {
    await _audioService.playPhrase(phrase, slow: slow);
  }

  Future<void> playPrompt(Phrase phrase) async {
    if (phrase.prompt != null) {
      await _audioService.playScript(phrase.prompt!.script);
    }
  }

  Future<void> playWord(Word word) async {
    await _audioService.playWord(word);
  }

  Future<void> playScript(String text) async {
    await _audioService.playScript(text);
  }
}
