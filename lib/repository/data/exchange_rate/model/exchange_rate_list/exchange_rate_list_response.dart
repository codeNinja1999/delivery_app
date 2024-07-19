// // ignore_for_file: file_names

// import 'dart:convert';

// ExchangeRateListResponseModel exchangeRateListResponseModelFromJson(
//         String str) =>
//     ExchangeRateListResponseModel.fromJson(json.decode(str));

// String exchangeRateListResponseModelToJson(
//         ExchangeRateListResponseModel data) =>
//     json.encode(data.toJson());

// class ExchangeRateListResponseModel {
//   ExchangeRateListResponseModel({
//     this.resultList,
//     this.dateFilter,
//     this.minValue,
//     this.maxValue,
//     this.interval,
//     this.processResult,
//     this.warningList,
//     this.errorList,
//   });

//   List<ResultList>? resultList;
//   String? dateFilter;
//   String? minValue;
//   String? maxValue;
//   String? interval;
//   bool? processResult;
//   List<WarningList>? warningList;
//   List<ErrorList>? errorList;

//   factory ExchangeRateListResponseModel.fromJson(Map<String, dynamic> json) =>
//       ExchangeRateListResponseModel(
//         resultList: List<ResultList>.from(
//             json["result_list"].map((x) => ResultList.fromJson(x))),
//         dateFilter: json["date_filter"],
//         minValue: json["min_value"],
//         maxValue: json["max_value"],
//         interval: json["interval"],
//         processResult: json["process_result"],
//         warningList: List<WarningList>.from(
//             json["warning_list"].map((x) => WarningList.fromJson(x))),
//         errorList: List<ErrorList>.from(
//             json["error_list"].map((x) => ErrorList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "result_list": List<dynamic>.from(resultList!.map((x) => x.toJson())),
//         "date_filter": dateFilter,
//         "min_value": minValue,
//         "max_value": maxValue,
//         "interval": interval,
//         "process_result": processResult,
//         "warning_list": List<dynamic>.from(warningList!.map((x) => x.toJson())),
//         "error_list": List<dynamic>.from(errorList!.map((x) => x.toJson())),
//       };
// }

// class ErrorList {
//   ErrorList({
//     this.errorCode,
//     this.errorMessage,
//   });

//   String? errorCode;
//   String? errorMessage;

//   factory ErrorList.fromJson(Map<String, dynamic> json) => ErrorList(
//         errorCode: json["error_code"],
//         errorMessage: json["error_message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "error_code": errorCode,
//         "error_message": errorMessage,
//       };
// }

// class ResultList {
//   ResultList({
//     this.country,
//     this.baseCurrencyCode,
//     this.counterCurrencyCode,
//     this.rate,
//     this.updateDate,
//   });

//   String? country;
//   String? baseCurrencyCode;
//   String? counterCurrencyCode;
//   String? rate;
//   String? updateDate;

//   factory ResultList.fromJson(Map<String, dynamic> json) => ResultList(
//         country: json["country"],
//         baseCurrencyCode: json["base_currency_code"],
//         counterCurrencyCode: json["counter_currency_code"],
//         rate: json["rate"],
//         updateDate: json["update_date"],
//       );

//   Map<String, dynamic> toJson() => {
//         "country": country,
//         "base_currency_code": baseCurrencyCode,
//         "counter_currency_code": counterCurrencyCode,
//         "rate": rate,
//         "update_date": updateDate,
//       };
// }

// class WarningList {
//   WarningList({
//     this.warningCode,
//     this.warningMessage,
//   });

//   String? warningCode;
//   String? warningMessage;

//   factory WarningList.fromJson(Map<String, dynamic> json) => WarningList(
//         warningCode: json["warning_code"],
//         warningMessage: json["warning_message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "warning_code": warningCode,
//         "warning_message": warningMessage,
//       };
// }
