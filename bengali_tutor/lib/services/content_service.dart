import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/content_models.dart';

class ContentService {
  Future<List<Level>> loadLevels() async {
    final List<Level> levels = [];
    final List<String> files = ['level_1.json', 'level_2.json', 'level_3.json'];

    for (final file in files) {
      try {
        final String jsonString = await rootBundle.loadString(
          'assets/data/$file',
        );
        final Map<String, dynamic> jsonData = json.decode(jsonString);
        levels.add(Level.fromJson(jsonData));
      } catch (e) {
        print('Error loading $file: $e');
      }
    }
    return levels;
  }
}
