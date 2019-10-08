import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';

class FileService {
  static FileService instance = FileService();

  Future<String> get _localPath async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _openFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> writeData(String data, String fileName) async {
    final file = await _openFile(fileName);
    return file.writeAsString(data);
  }

  Future<String> readData(String fileName) async {
    try {
      final file = await _openFile(fileName);
      var exists = await file.exists();
      if (!exists) return '';
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return e.toString();
    }
  }
}