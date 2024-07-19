// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationResponseModel notificationResponseModelFromJson(String str) =>
    NotificationResponseModel.fromJson(json.decode(str));

String notificationResponseModelToJson(NotificationResponseModel data) => json.encode(data.toJson());

class NotificationResponseModel {
  NotificationResponseModel({
    this.resultList,
    this.processResult,
  });

  List<NotificationResultList>? resultList;
  bool? processResult;

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
        resultList:
            List<NotificationResultList>.from(json["result_list"].map((x) => NotificationResultList.fromJson(x))),
        processResult: json["process_result"],
      );

  Map<String, dynamic> toJson() => {
        "result_list": List<dynamic>.from(resultList!.map((x) => x.toJson())),
        "process_result": processResult,
      };
}

class NotificationResultList {
  NotificationResultList({
    this.msgBody,
    this.country,
    this.fileUrl,
    this.msgTitle,
    this.sendDate,
    this.dateDifference,
  });

  String? msgBody;
  String? country;
  String? fileUrl;
  String? msgTitle;
  String? dateDifference;
  String? sendDate;

  factory NotificationResultList.fromJson(Map<String, dynamic> json) => NotificationResultList(
        msgBody: json["msg_body"],
        country: json["country"],
        fileUrl: json["fileUrl"],
        msgTitle: json["msg_title"],
        sendDate: json["senddate"],
        dateDifference: json["datediff"],
      );

  Map<String, dynamic> toJson() => {
        "msg_body": msgBody,
        "country": country,
        "fileUrl": fileUrl,
        "msg_title": msgTitle,
        "senddate": fileUrl,
        "datediff": fileUrl,
      };
}
