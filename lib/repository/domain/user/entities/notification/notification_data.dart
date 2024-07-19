class NotificationData {
  final String? transactionId;
  final String? messageType;
  final String? messageTitle;
  final String? sentTs;
  final String? messageBody;
  final String? timeDifference;
  final String? lastUpdateTs;
  final String? confirmedFlag;

  NotificationData({
    this.transactionId,
    this.messageType,
    this.messageTitle,
    this.sentTs,
    this.messageBody,
    this.timeDifference,
    this.lastUpdateTs,
    this.confirmedFlag,
  });
}
