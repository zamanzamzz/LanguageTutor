// lib/services/progress_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  final SharedPreferences prefs;

  ProgressService(this.prefs);

  static const String _completedTopicsKey = 'completed_topics';
  static const String _completedScenariosKey = 'completed_scenarios';

  List<String> get completedTopics => prefs.getStringList(_completedTopicsKey) ?? [];
  List<String> get completedScenarios => prefs.getStringList(_completedScenariosKey) ?? [];

  Future<void> markTopicComplete(String topicId) async {
    final list = completedTopics;
    if (!list.contains(topicId)) {
      list.add(topicId);
      await prefs.setStringList(_completedTopicsKey, list);
    }
  }

  Future<void> markScenarioComplete(String scenarioId) async {
    final list = completedScenarios;
    if (!list.contains(scenarioId)) {
      list.add(scenarioId);
      await prefs.setStringList(_completedScenariosKey, list);
    }
  }

  bool isTopicCompleted(String topicId) => completedTopics.contains(topicId);
  bool isScenarioCompleted(String scenarioId) => completedScenarios.contains(scenarioId);

  int get totalCompleted => completedTopics.length + completedScenarios.length;
}
