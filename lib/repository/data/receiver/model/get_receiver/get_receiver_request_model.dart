class GetReceiverData {
  GetReceiverData({
    this.pageNo,
    this.displayDataNo,
  });

  String? pageNo;
  String? displayDataNo;

  factory GetReceiverData.fromJson(Map<String, dynamic> json) =>
      GetReceiverData(
        pageNo: json["page_n"],
        displayDataNo: json["display_data_no"],
      );

  Map<String, dynamic> toJson() => {
        "page_n": pageNo,
        "display_data_no": displayDataNo,
      };
}
