enum CatalogType {
  countryList,
  sendingCountryList,
  remitCountryList,
  postalCode,
  occupationList,
  incomeList,
  documentList,
  receiverIdType,
  visaList,
  prefectureLis,
  cityList,
  townList,
  streetType,
  remitterRelation,
  purposeOfRemittance,
  paymentMode,
  bankList,
  branchList,
  depositType,
  receivingCurrency,
  receiverType,
  idIssueJurisdiction,
  depositBank,
}

extension CatlogTypeValue on CatalogType {
  String get value => getValue();
  String getValue() {
    switch (this) {
      case CatalogType.countryList:
        return "1003";
      case CatalogType.sendingCountryList:
        return "1043";
      case CatalogType.remitCountryList:
        return "1018";
      case CatalogType.postalCode:
        return "1004";
      case CatalogType.occupationList:
        return "1005";
      case CatalogType.incomeList:
        return "14";
      case CatalogType.documentList:
        return "08";
      case CatalogType.receiverIdType:
        return "1024";
      case CatalogType.visaList:
        return "62";
      case CatalogType.prefectureLis:
        return "99";
      case CatalogType.cityList:
        return "1037";
      case CatalogType.townList:
        return "1038";
      case CatalogType.streetType:
        return "1044";
      case CatalogType.remitterRelation:
        return "1021";
      case CatalogType.purposeOfRemittance:
        return "1022";
      case CatalogType.paymentMode:
        return "1020";
      case CatalogType.bankList:
        return "1040";
      case CatalogType.branchList:
        return "1026";
      case CatalogType.depositType:
        return "1041";
      case CatalogType.receivingCurrency:
        return "1042";
      case CatalogType.idIssueJurisdiction:
        return "1045";
      case CatalogType.depositBank:
        return "1048";
      case CatalogType.receiverType:
        return "000";
    }
  }
}
