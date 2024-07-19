class TransactionListFilter {
  final String? pageNumber;
  final String? itemCount;
  final String? startDate;
  final String? endDate;
  final String? issueType;

  TransactionListFilter(
      {this.pageNumber,
      this.itemCount,
      this.startDate,
      this.endDate,
      this.issueType,});
}
