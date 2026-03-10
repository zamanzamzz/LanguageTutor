import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/content_models.dart';
import '../../services/recorder_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RecorderUnitScreen extends StatefulWidget {
  final Unit unit;

  const RecorderUnitScreen({super.key, required this.unit});

  @override
  State<RecorderUnitScreen> createState() => _RecorderUnitScreenState();
}

class _RecorderUnitScreenState extends State<RecorderUnitScreen> {
  final RecorderService _recorderService = RecorderService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Track recording state
  String? _currentlyRecordingId; // ID of phrase/word being recorded

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.title),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.unit.phrases.length,
        itemBuilder: (context, index) {
          final phrase = widget.unit.phrases[index];
          return _buildPhraseRecorderCard(phrase);
        },
      ),
    );
  }

  Widget _buildPhraseRecorderCard(Phrase phrase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              phrase.english,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              phrase.bengali,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Phrase Level Recordings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRecordButton(
                  'Natural',
                  phrase.audioPathNatural ?? '${phrase.id}_nat.m4a',
                ),
                _buildRecordButton(
                  'Slow',
                  phrase.audioPathSlow ?? '${phrase.id}_slo.m4a',
                ),
              ],
            ),

            if (phrase.words.isNotEmpty) ...[
              const Divider(height: 24),
              const Text(
                'Words:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: phrase.words.map((word) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          word.bengali,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        _buildMiniRecordButton(
                          word.audioPath ?? '${word.id}.m4a',
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecordButton(String label, String fileName) {
    return FutureBuilder<bool>(
      future: _recorderService.fileExists(fileName),
      builder: (context, snapshot) {
        final bool exists = snapshot.data ?? false;
        final bool isRecording = _currentlyRecordingId == fileName;

        return Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (isRecording) {
                      await _recorderService.stopRecording();
                      setState(() {
                        _currentlyRecordingId = null;
                      });
                    } else {
                      // Check perm first
                      if (await _recorderService.checkPermission()) {
                        await _recorderService.startRecording(fileName);
                        setState(() {
                          _currentlyRecordingId = fileName;
                        });
                      }
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: isRecording
                        ? Colors.red
                        : (exists ? Colors.green : Colors.grey[300]),
                    child: Icon(
                      isRecording
                          ? Icons.stop
                          : (exists ? Icons.mic : Icons.mic_none),
                      color: Colors.white,
                    ),
                  ),
                ),
                if (exists && !isRecording) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      final Directory appDocDir =
                          await getApplicationDocumentsDirectory();
                      final File file = File('${appDocDir.path}/$fileName');
                      await _audioPlayer.play(DeviceFileSource(file.path));
                    },
                    child: const Icon(Icons.play_arrow, color: Colors.blue),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      await _recorderService.deleteRecording(fileName);
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMiniRecordButton(String fileName) {
    return FutureBuilder<bool>(
      future: _recorderService.fileExists(fileName),
      builder: (context, snapshot) {
        final bool exists = snapshot.data ?? false;
        final bool isRecording = _currentlyRecordingId == fileName;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                if (isRecording) {
                  await _recorderService.stopRecording();
                  setState(() {
                    _currentlyRecordingId = null;
                  });
                } else {
                  if (await _recorderService.checkPermission()) {
                    await _recorderService.startRecording(fileName);
                    setState(() {
                      _currentlyRecordingId = fileName;
                    });
                  }
                }
              },
              child: Icon(
                isRecording
                    ? Icons.stop_circle
                    : (exists ? Icons.check_circle : Icons.mic),
                color: isRecording
                    ? Colors.red
                    : (exists ? Colors.green : Colors.grey),
                size: 24,
              ),
            ),
            if (exists && !isRecording) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () async {
                  final Directory appDocDir =
                      await getApplicationDocumentsDirectory();
                  final File file = File('${appDocDir.path}/$fileName');
                  await _audioPlayer.play(DeviceFileSource(file.path));
                },
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.blue,
                  size: 20,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
