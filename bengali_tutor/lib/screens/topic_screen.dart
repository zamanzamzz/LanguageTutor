// lib/screens/topic_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_models.dart';
import '../providers/app_provider.dart';
import '../widgets/phrase_card.dart';

class TopicScreen extends StatelessWidget {
  final Topic topic;

  const TopicScreen({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topic.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${topic.phrases.length} Phrases',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: topic.phrases.length,
              itemBuilder: (context, index) {
                return PhraseCard(phrase: topic.phrases[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).completeTopic(topic.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Topic marked as complete! Great job!')),
                );
                Navigator.pop(context);
              },
              child: const Text('Mark Complete'),
            ),
          ),
        ],
      ),
    );
  }
}
