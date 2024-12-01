export 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as debug;

extension EncryptionUtil on String {
  static final key = Key.fromLength(32);
  static final iv = IV.fromLength(16);

  String encrypting() {
    try {
      final e = Encrypter(AES(key, mode: AESMode.cbc));
      final encryptedData = e.encrypt(this, iv: iv);
      return encryptedData.base64;
    } catch (e) {
      debug.debugPrint("Encrypting Error: $e");
      return "";
    }
  }

  String? decrypting() {
    try {
      final e = Encrypter(AES(key, mode: AESMode.cbc));
      final decryptedData = e.decrypt(Encrypted.fromBase64(this), iv: iv);
      return decryptedData;
    } catch (e) {
      debug.debugPrint("Decrypting Error $e");
      return null;
    }
  }
}
