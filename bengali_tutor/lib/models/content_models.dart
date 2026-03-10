// lib/models/content_models.dart

class Level {
  final String id;
  final String title;
  final String description;
  final List<Unit> units;

  Level({
    required this.id,
    required this.title,
    required this.description,
    required this.units,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      units: (json['units'] as List).map((u) => Unit.fromJson(u)).toList(),
    );
  }
}

class Unit {
  final String id;
  final String title;
  final List<Phrase> phrases;

  Unit({required this.id, required this.title, required this.phrases});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      title: json['title'],
      phrases: (json['phrases'] as List)
          .map((p) => Phrase.fromJson(p))
          .toList(),
    );
  }
}

class Phrase {
  final String id;
  final String english;
  final String bengali; // Transliterated
  final String bengaliScript; // Hidden for TTS
  final String? audioPathNatural;
  final String? audioPathSlow;
  final List<Word> words;
  final String? literal;
  final String? culturalNote;
  final bool isFormal;

  Phrase({
    required this.id,
    required this.english,
    required this.bengali,
    required this.bengaliScript,
    this.audioPathNatural,
    this.audioPathSlow,
    this.words = const [],
    this.literal,
    this.culturalNote,
    this.isFormal = false,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      id: json['id'],
      english: json['english'],
      bengali: json['bengali'],
      bengaliScript:
          json['script'] ?? json['bengaliScript'], // Support both for migration
      audioPathNatural: json['audio_natural'],
      audioPathSlow: json['audio_slow'],
      words:
          (json['words'] as List?)?.map((w) => Word.fromJson(w)).toList() ?? [],
      literal: json['literal'],
      culturalNote: json['culturalNote'],
      isFormal: json['isFormal'] ?? false,
    );
  }
}

class Word {
  final String id;
  final String bengali; // Transliterated
  final String bengaliScript;
  final String? audioPath;

  Word({
    required this.id,
    required this.bengali,
    required this.bengaliScript,
    this.audioPath,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      bengali: json['bengali'],
      bengaliScript: json['script'] ?? '',
      audioPath: json['audio'],
    );
  }
}

// Keep existing Scenario models for Roleplay mode compatibility
// We might migrate these to JSON later as well.

enum Difficulty { beginner, intermediate, advanced }

class Scenario {
  final String id;
  final String title;
  final String description;
  final Difficulty difficulty;
  final List<DialogueStep> steps;

  Scenario({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.steps,
  });
}

class DialogueStep {
  final String stepId;
  final String speakerName;
  final String textBengali; // Transliterated
  final String textScript; // Hidden for TTS
  final String textEnglish;
  final List<ResponseOption> options;
  final Hint? hint;

  DialogueStep({
    required this.stepId,
    required this.speakerName,
    required this.textBengali,
    required this.textScript,
    required this.textEnglish,
    required this.options,
    this.hint,
  });
}

class ResponseOption {
  final String textBengali; // Transliterated
  final String textScript; // Hidden for TTS
  final String textEnglish;
  final String nextStepId;
  final bool isCorrect; // For learning purposes

  ResponseOption({
    required this.textBengali,
    required this.textScript,
    required this.textEnglish,
    required this.nextStepId,
    this.isCorrect = true,
  });
}

class Hint {
  final List<String> vocabulary;
  final String? culturalNote;
  final String? literalTranslation;

  Hint({required this.vocabulary, this.culturalNote, this.literalTranslation});
}
