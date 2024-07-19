class ChangeTradePinInfo {
  final String currentPin;
  final String newPin;
  final bool? useAsLoginPassword;
  final String? issueType;
  final String? processID;

  ChangeTradePinInfo({
    required this.currentPin,
    required this.newPin,
    this.useAsLoginPassword,
    this.issueType,
    this.processID,
  });
}
