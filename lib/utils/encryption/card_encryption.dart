import 'package:encrypt/encrypt.dart';
class EncryptionUtils {
  static final key = Key.fromSecureRandom(32);
  static final iv = IV.fromSecureRandom(16);
  static final encrypter = Encrypter(AES(key));

  static encryptData(text) {
    return encrypter.encrypt(text, iv: iv);
  }

  static decryptData(encryptedData) {
    return encrypter.decrypt(encryptedData, iv: iv);
  }
}