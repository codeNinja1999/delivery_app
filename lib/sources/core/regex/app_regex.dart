class AppRegex {
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  // static final RegExp pin = RegExp(
  //     r"^(?!(.)\1{3})(?!19|20)(?!0123|1234|2345|3456|4567|5678|6789|7890|0987|9876|8765|7654|6543|5432|4321|3210)\d{4}$");
  //static final RegExp pin = RegExp(r"\d{6}$");
  static final RegExp password =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|:;<>,.?/~`])[A-Za-z0-9!@#$%^&*()_+{}|:;<>,.?/~`]{8,}$');
  static final RegExp pin = RegExp(r"^(\d)\1*$");
  static final RegExp pin2 = RegExp(r"^0?1?2?3?4?5?6?7?8?9?$");
  static final RegExp pin3 = RegExp(r"^9?8?7?6?5?4?3?2?1?0?$");
  static final RegExp mobileNumber = RegExp(r'^\d{9,11}$');
  static final RegExp eightDigit = RegExp(r'^.{8,}$');
  static final RegExp spacialAndNumeric = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\-]).*$');
  static final RegExp oneLetterCapital = RegExp(r'[A-Z]');
  static final RegExp floatDigit = RegExp(r'^\d*\.?\d*');
}
