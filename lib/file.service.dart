import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FileService {
  static FileService instance = FileService();
  final storage = new FlutterSecureStorage();

  Future<String> get _localPath async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _openFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<void> writeData(String data) async {
    await storage.write(key: 'note', value: data);
  }

  Future<String> readData() async {
    return await storage.read(key: 'note');
  }
}