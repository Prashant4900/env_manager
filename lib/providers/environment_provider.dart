import 'dart:io';

import 'package:env_manager/models/environment_variable.dart';
import 'package:env_manager/services/file_service.dart';
import 'package:flutter/foundation.dart';

class EnvironmentProvider extends ChangeNotifier {
  final FileService _fileService = FileService();

  File? _selectedFile;
  String _fileContent = '';
  bool _isLoading = false;
  String? _error;

  File? get selectedFile => _selectedFile;
  String get fileContent => _fileContent;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> pickFile() async {
    try {
      _setLoading(true);
      _error = null;

      // On macOS, we don't need to request permission before picking a file
      // as the system's file picker will handle the necessary permissions
      final file = await _fileService.pickFile();
      if (file != null) {
        _selectedFile = file;
        await _loadFileContent();
      }
    } catch (e) {
      _error = 'Failed to pick file: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addEnvironmentVariable(EnvironmentVariable variable) async {
    try {
      _setLoading(true);
      _error = null;

      if (_selectedFile == null) {
        _error = 'No file selected';
        return;
      }

      // On macOS, we have write access to files that the user has selected
      await _fileService.appendToFile(_selectedFile!, variable.toString());
      await _loadFileContent();
    } catch (e) {
      _error = 'Failed to add environment variable: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshFile() async {
    if (_selectedFile == null) return;

    try {
      _setLoading(true);
      _error = null;
      await _loadFileContent();
    } catch (e) {
      _error = 'Failed to refresh file: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> openFileInEditor() async {
    if (_selectedFile == null) return;

    try {
      _setLoading(true);
      _error = null;

      // Use the Process.run method to open the file with the default editor
      final result = await Process.run('open', ['-t', _selectedFile!.path]);

      if (result.exitCode != 0) {
        throw Exception('Failed to open file in editor: ${result.stderr}');
      }
    } catch (e) {
      _error = 'Failed to open file in editor: $e';
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadFileContent() async {
    if (_selectedFile == null) return;

    try {
      _fileContent = await _fileService.readFile(_selectedFile!);
      notifyListeners();
    } catch (e) {
      _error = 'Error reading file: $e';
      rethrow;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
