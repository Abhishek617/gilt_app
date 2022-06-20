import 'package:encrypt/encrypt.dart';

class EncryptionUtils {
  // static final key = Key.fromSecureRandom(32);
  static final key = Key.fromUtf8("WdVtHgN9UuY2GuVqCzDp3045fA2E5dGC");
  static final iv = IV.fromSecureRandom(16);
  static final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

  static String encryptData(text) {
    return encrypter.encrypt(text, iv: iv).base16;
  }

  static String decryptData(encryptedData) {
    return encrypter.decrypt64(encryptedData, iv: iv);
  }
}
