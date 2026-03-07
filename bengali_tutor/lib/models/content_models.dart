// lib/models/content_models.dart
enum TopicType {
  greetings,
  introductions,
  shopping,
  food,
  directions,
  family,
}

enum Difficulty {
  beginner,
  intermediate,
  advanced,
}

class Topic {
  final String id;
  final String title;
  final String icon;
  final TopicType type;
  final List<Phrase> phrases;

  Topic({
    required this.id,
    required this.title,
    required this.icon,
    required this.type,
    required this.phrases,
  });
}

class Phrase {
  final String english;
  final String bengali; // Transliterated (e.g., "Kemon acho?")
  final String bengaliScript; // Hidden for TTS (e.g., "কেমন আছো?")
  final String? literal;
  final String? culturalNote;
  final bool isFormal;

  Phrase({
    required this.english,
    required this.bengali,
    required this.bengaliScript,
    this.literal,
    this.culturalNote,
    this.isFormal = false,
  });
}

// Conversation / Roleplay Models

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

  Hint({
    required this.vocabulary,
    this.culturalNote,
    this.literalTranslation,
  });
}
