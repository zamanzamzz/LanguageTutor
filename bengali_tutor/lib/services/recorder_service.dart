import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:archive/archive_io.dart';
import 'package:share_plus/share_plus.dart';

class RecorderService {
  final AudioRecorder _recorder = AudioRecorder();

  Future<bool> checkPermission() async {
    // Check permission using permission_handler for Android/iOS specifics if needed
    // But record package handles it mostly.
    return await _recorder.hasPermission();
  }

  Future<void> startRecording(String fileName) async {
    if (await _recorder.hasPermission()) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String path = '${appDocDir.path}/$fileName';

      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
    }
  }

  Future<String?> stopRecording() async {
    return await _recorder.stop();
  }

  Future<bool> fileExists(String fileName) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final File file = File('${appDocDir.path}/$fileName');
    return await file.exists();
  }

  Future<void> deleteRecording(String fileName) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final File file = File('${appDocDir.path}/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> exportRecordings() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDocDir.listSync();

    var encoder = ZipFileEncoder();
    final zipPath = '${appDocDir.path}/bengali_tutor_recordings.zip';
    encoder.create(zipPath);

    int count = 0;
    for (var file in files) {
      if (file is File &&
          (file.path.endsWith('.m4a') || file.path.endsWith('.aac'))) {
        encoder.addFile(file);
        count++;
      }
    }
    encoder.close();

    if (count > 0) {
      await Share.shareXFiles([
        XFile(zipPath),
      ], text: 'Bengali Tutor Recordings ($count files)');
    }
  }
}
