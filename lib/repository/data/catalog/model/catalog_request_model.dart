class CatalogRequestModel {
  CatalogRequestModel({
    this.catalogueType,
    this.language,
    this.field1,
    this.field2,
    this.field3,
    this.field4,
  });
  String? catalogueType;

  String? language;
  String? field1;
  String? field2;
  String? field3;
  String? field4;

  Map<String, dynamic> toJson() => {
        "item.catalogue_type": catalogueType,
        "item.language": language,
        "item.additional_field1": field1,
        "item.additional_field2": field2,
        "item.additional_field3": field3,
        "item.additional_field4": field4,
      };
}
