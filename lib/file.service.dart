import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

class FileService {
  static FileService instance = FileService();
  final storage = new FlutterSecureStorage();
  final cryptor = new PlatformStringCryptor();
  bool _hasFileKey = false;

  bool get hasFileKey {
    return _hasFileKey;
  }

  Future<void> writeData(String data) async {
    final String key = await storage.read(key: 'file_key');
    final String encrypted = await cryptor.encrypt(data, key);
    await storage.write(key: 'note', value: encrypted);
  }

  Future<String> readData() async {
    try {
      final String encrypted = await storage.read(key: 'note');
      final String key = await storage.read(key: 'file_key');
      if (encrypted != null) {
        return await cryptor.decrypt(encrypted, key);
      }
      return '';
    } on MacMismatchException {
      print('error');
    }
    return null;
  }

  Future<void> createFileKey(String password) async {
    final String encrypted = await storage.read(key: 'note');
    final String key = await storage.read(key: 'file_key');
    final String salt = await FileService.instance.cryptor.generateSalt();
    final String newKey = await FileService.instance.cryptor
        .generateKeyFromPassword(password, salt);
    await storage.write(key: 'file_key', value: newKey);
    _hasFileKey = true;
    if (encrypted != null) {
      final String decrypted = await cryptor.decrypt(encrypted, key);
      writeData(decrypted);
    }
  }
}
