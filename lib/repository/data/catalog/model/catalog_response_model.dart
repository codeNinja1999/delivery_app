class CatalogResponseModel {
  CatalogResponseModel({
    this.catalogueList,
  });

  final List<CatalogueList>? catalogueList;

  factory CatalogResponseModel.fromJson(Map<String, dynamic> json) =>
      CatalogResponseModel(
        catalogueList: List<CatalogueList>.from(
            json["catalogue_list"].map((x) => CatalogueList.fromJson(x))),
      );
}

class CatalogueList {
  CatalogueList({
    this.data,
    this.value,
    this.additionalData,
    this.accountNo,
    this.accountType,
    this.additionalValue,
    this.language,
    this.additionalValue2,
    this.additionalValue3,
    this.additionalValue4,
  });

  final String? data;
  final String? value;
  final String? additionalData;
  final String? accountNo;
  final String? accountType;
  final String? additionalValue;
  final String? language;
  final String? additionalValue2;
  final String? additionalValue3;
  final String? additionalValue4;

  factory CatalogueList.fromJson(Map<String, dynamic> json) => CatalogueList(
        data: json["data"],
        value: json["value"],
        additionalData: json["additional_data"],
        accountNo: json["account_no"],
        accountType: json["account_type"],
        additionalValue: json["additional_value"],
        language: json["language"],
        additionalValue2: json["additional_value2"],
        additionalValue3: json["additional_value3"],
        additionalValue4: json["additional_value4"],
      );
}
