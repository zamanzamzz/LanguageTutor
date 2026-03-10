import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../services/recorder_service.dart';
import 'recorder_unit_screen.dart';

class RecorderHomeScreen extends StatelessWidget {
  const RecorderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecorderService recorderService = RecorderService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorder Studio'),
        backgroundColor: Colors.redAccent,
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.levels.length,
            itemBuilder: (context, index) {
              final level = provider.levels[index];
              return ExpansionTile(
                title: Text(
                  level.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: level.units.map((unit) {
                  return ListTile(
                    title: Text(unit.title),
                    subtitle: Text('${unit.phrases.length} phrases'),
                    trailing: const Icon(Icons.mic, color: Colors.redAccent),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecorderUnitScreen(unit: unit),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await recorderService.exportRecordings();
        },
        label: const Text('Export All'),
        icon: const Icon(Icons.share),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
