import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class WingsSecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final encrypt.Encrypter _encrypter;
  final encrypt.IV _iv;

  WingsSecureStorage(String encryptionKey)
      : _encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(encryptionKey))),
        // _iv = encrypt.IV.fromLength(16); // Generate a random IV, or use a constant one if needed
        _iv = encrypt.IV.fromUtf8('uG7zqC3":%}ek10b'); // Changed IV to be 16 characters long

  Future<void> write({required String key, required String value}) async {
    final encryptedValue = _encrypter.encrypt(value, iv: _iv).base64;
    await _storage.write(key: key, value: encryptedValue);
  }


  Future<String?> read({required String key}) async {
    final encryptedValue = await _storage.read(key: key,);
    if (encryptedValue != null) {
      return _encrypter.decrypt64(encryptedValue,iv: _iv);
    }
    return null;
  }

  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}