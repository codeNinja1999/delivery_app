import 'package:easy_localization/easy_localization.dart';
import 'package:encrypt/encrypt.dart';

extension StringExtensions on String {
  String get value => this.tr();

  String encrypted({required String key}) {
    final encKey = Key.fromUtf8(key);
    final iv = IV.fromUtf8(key);
    final encrypter = Encrypter(AES(encKey, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(this, iv: iv);
    return encrypted.base64;
  }

  String decrypted({required String key}) {
    final encKey = Key.fromUtf8(key);
    final iv = IV.fromUtf8(key);
    final encrypter = Encrypter(AES(encKey, mode: AESMode.cbc));
    try {
      final decrypted = encrypter.decrypt(Encrypted.from64(this), iv: iv);
      return decrypted;
    } catch (e) {
      print(e);
      return "";
    }
  }

  String formattedDate(String format) {
    final date = DateTime.parse(this);
    return DateFormat(format).format(date);
  }
}

extension InitialStringExtension on String {
  String getInitials() {
    List<String> nameParts = split(" ");

    if (nameParts.isNotEmpty) {
      if (nameParts.length >= 3) {
        // Ensure that nameParts[0] and nameParts[1] have elements before accessing indices
        if (nameParts[0].isNotEmpty && nameParts[1].isNotEmpty && nameParts[2].isNotEmpty) {
          return "${nameParts[0][0]}${nameParts[1][0]}${nameParts[2][0]}";
        } else if (nameParts[0].isNotEmpty && nameParts[2].isNotEmpty) {
          return "${nameParts[0][0]}${nameParts[2][0]}";
        } else if (nameParts[0].isNotEmpty && nameParts[1].isNotEmpty) {
          return "${nameParts[0][0]}${nameParts[1][0]}";
        } else if (nameParts[0].isNotEmpty) {
          return nameParts[0][0];
        }
      } else if (nameParts[0].isNotEmpty) {
        return nameParts[0][0];
      }
    }
    return "N/A";
  }
}
