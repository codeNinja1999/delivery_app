import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class JapanesePostalCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final trimmed = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (trimmed.length > 3) {
      return TextEditingValue(
        text: '${trimmed.substring(0, 3)}-${trimmed.substring(3)}',
        selection: TextSelection.collapsed(offset: trimmed.length + 1),
      );
    } else {
      return TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
    }
  }
}
