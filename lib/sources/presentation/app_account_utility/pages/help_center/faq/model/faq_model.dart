class FAQModel {
  final List<FAQItem>? paymentAndFees;
  final List<FAQItem>? appTutorials;

  FAQModel({
    this.paymentAndFees,
    this.appTutorials,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) => FAQModel(
        paymentAndFees: json["payment_and_fees"] == null
            ? []
            : List<FAQItem>.from(json["payment_and_fees"]!.map((x) => FAQItem.fromJson(x))),
        appTutorials:
            json["app_tutorials"] == null ? [] : List<FAQItem>.from(json["app_tutorials"]!.map((x) => FAQItem.fromJson(x))),
      );
}

class FAQItem {
  final String? title;
  final String? question;
  final String? answer;

  FAQItem({
    this.title,
    this.question,
    this.answer,
  });

  factory FAQItem.fromJson(Map<String, dynamic> json) => FAQItem(
        title: json["title"],
        question: json["question"],
        answer: json["answer"],
      );
}
