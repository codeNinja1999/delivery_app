class TransactionHistoryRequest {
  TransactionHistoryRequest({
    this.pageNo,
    this.displayDataNo,
    this.tradeFormDate,
    this.tradeToDate,
    this.issueType,
  });

  String? pageNo;
  String? displayDataNo;
  String? tradeFormDate;
  String? tradeToDate;
  String? issueType;

  Map<String, dynamic> toJson() => {
        "page_no": pageNo,
        "display_data_no": displayDataNo,
        "trade_form_date": tradeFormDate,
        "trade_to_date": tradeToDate,
        "issue_type": issueType,
      };
}
