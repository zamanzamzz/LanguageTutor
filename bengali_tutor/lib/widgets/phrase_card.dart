import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_models.dart';
import '../providers/app_provider.dart';

class PhraseCard extends StatelessWidget {
  final Phrase phrase;

  const PhraseCard({Key? key, required this.phrase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: English & Audio Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    phrase.english,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.speed, size: 20),
                      color: Colors.orange,
                      onPressed: () => provider.playPhrase(phrase, slow: true),
                      tooltip: 'Play Slow',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.volume_up, size: 24),
                      color: Colors.teal,
                      onPressed: () => provider.playPhrase(phrase, slow: false),
                      tooltip: 'Play Natural',
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12.0),

            // Row 2: Interactive Bengali Text
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: phrase.words.isNotEmpty
                  ? phrase.words.map((word) {
                      return InkWell(
                        onTap: () => provider.playWord(word),
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.teal.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            word.bengali,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList()
                  : [
                      Text(
                        phrase.bengali,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.teal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
            ),

            // Row 3: Metadata (Formal/Literal/Culture)
            if (phrase.culturalNote != null ||
                phrase.literal != null ||
                phrase.isFormal) ...[
              const Divider(height: 24.0),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (phrase.isFormal)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'FORMAL',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  if (phrase.literal != null)
                    Text(
                      'Lit: "${phrase.literal}"',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
              if (phrase.culturalNote != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        size: 16,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          phrase.culturalNote!,
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey[700],
                          ),
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
