class AppCredentialData {
  AppCredentialData(this.processKey);
  final String processKey;

  factory AppCredentialData.fromJson(Map<String, dynamic> json) =>
      AppCredentialData(
        json["processKey"],
      );

  Map<String, dynamic> toJson() => {
        "processKey": processKey,
      };
}
