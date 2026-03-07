// lib/widgets/phrase_card.dart
import 'package:flutter/material.dart';
import '../models/content_models.dart';
import 'audio_button.dart';

class PhraseCard extends StatelessWidget {
  final Phrase phrase;

  const PhraseCard({Key? key, required this.phrase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phrase.english,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        phrase.bengali,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.teal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                AudioButton(textToSpeak: phrase.bengaliScript),
              ],
            ),
            if (phrase.culturalNote != null || phrase.literal != null || phrase.isFormal) ...[
              const Divider(height: 24.0),
              if (phrase.isFormal)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('FORMAL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.brown)),
                ),
              if (phrase.isFormal && (phrase.culturalNote != null || phrase.literal != null))
                const SizedBox(height: 8),
              if (phrase.literal != null)
                Text('Literal: "${phrase.literal}"', style: TextStyle(fontSize: 14.0, color: Colors.grey[700])),
              if (phrase.culturalNote != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          phrase.culturalNote!,
                          style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
