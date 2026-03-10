import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/content_models.dart';
import '../providers/app_provider.dart';
import '../widgets/phrase_card.dart';

class TopicScreen extends StatelessWidget {
  final Unit unit;

  const TopicScreen({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(unit.title), elevation: 0),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.teal,
            child: Text(
              '${unit.phrases.length} Phrases',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 80),
              itemCount: unit.phrases.length,
              itemBuilder: (context, index) {
                return PhraseCard(phrase: unit.phrases[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<AppProvider>(
            context,
            listen: false,
          ).completeUnit(unit.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unit marked as complete!')),
          );
          Navigator.pop(context);
        },
        label: const Text('Complete Unit'),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
