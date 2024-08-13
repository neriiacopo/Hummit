import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Recorder {
  final Record _record = Record();
  bool isRecording = false;
  String filePath = "";
  String error = "";

  Future<void> initializeRecordingPath() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    filePath = '${appDocDirectory.path}/audio.m4a';
  }

  Future<void> startRecording() async {
    try {
      if (await _record.hasPermission()) {
        isRecording = true;
        error = "";
        await _record.start(
          path: filePath,
        );
      }
    } catch (e) {
      error = "Error starting recording: $e";
      isRecording = false;
    }
  }

  Future<String?> stopRecording() async {
    try {
      final path = await _record.stop();
      isRecording = false;
      return path;
    } catch (e) {
      error = "Error stopping recording: $e";
      isRecording = false;
      return null;
    }
  }
}
