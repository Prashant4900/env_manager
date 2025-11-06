import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileService {
  Future<File?> pickFile() async {
    try {
      // On macOS, we don't need to request permission before picking a file
      // The system's file picker will handle the necessary permissions
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> readFile(File file) async {
    try {
      return await file.readAsString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> appendToFile(File file, String content) async {
    try {
      await file.writeAsString(
        '\n$content',
        mode: FileMode.append,
        flush: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  // On macOS, we don't need to request permission to access files
  // that the user has explicitly selected through the file picker
  Future<bool> requestFileAccess() async {
    return true;
  }
}
