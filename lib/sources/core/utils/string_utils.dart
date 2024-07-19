import '../app_core.dart';

import '../../config/config.dart';

class StringUtils {
  static String formatPhoneNumber(String phoneNumber) {
    // Extract first two characters
    String prefix = phoneNumber.substring(0, 2);

    // Replace remaining characters with "X"
    String maskedDigits = phoneNumber.substring(2).replaceAll(RegExp(r'\d'), 'X');

    // Concatenate the prefix and maskedDigits
    String formattedNumber = "$prefix$maskedDigits";

    return formattedNumber;
  }

  static String formatDouble(String? amount) {
    if (amount != null) {
      String cleanedString = amount.replaceAll('.00', '');
      // final doubleValue = double.parse(cleanedString);
      // String totalAmount = doubleValue.toInt().toString();
      // return totalAmount;
      return cleanedString;
    } else {
      return "0";
    }
  }

  static String securePin(String transactionPin) {
    final timeStamp = Uri.encodeComponent('${DateTime.now().millisecondsSinceEpoch ~/ 1000}');
    final signatureValue = "$timeStamp.$transactionPin.${AppConfig.shared.appKey}";
    final verifyPin = signatureValue.encrypted(key: AppConfig.shared.appKey);
    final splitSignature = "$timeStamp.$verifyPin";

    return splitSignature;
  }

  static String getCountryName(String countryCode) {
    final Map<String, String> countryCodes = {
      'USA': LocaleKeys.english.value,
      'NPL': LocaleKeys.nepal.value,
      'JPN': LocaleKeys.japanese.value,
      // Add more country codes and names as needed
    };

    return countryCodes[countryCode.toUpperCase()] ?? LocaleKeys.unknownCountry.value;
  }
}
