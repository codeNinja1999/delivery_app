import 'package:fresh_fold_delivery/repository/repository.dart';

extension CatalogueResponseDataMapping on CatalogueList {
  Catalog toDomain() {
    final responseData = Catalog(id: data ?? "", value: value ?? "");
    return responseData;
  }

  Country toCountryData() {
    final responseData = Country(
      id: data ?? "",
      value: value ?? "",
      currencyCode: additionalValue2,
      telephoneCode: additionalData,
      countryCode: data,
    );
    return responseData;
  }

  PostalAddress toPostCode() {
    final responseData = PostalAddress(
      id: data ?? "",
      value: value ?? "",
      postalAddress: data,
      state: Catalog(id: value ?? "", value: value ?? ""),
      city: Catalog(id: additionalValue ?? "", value: additionalValue ?? ""),
      street: additionalValue2,
      street2: additionalValue3,
    );
    return responseData;
  }

  ReceivingCountry toReceivingCountryData() {
    final responseData = ReceivingCountry(
      id: data ?? "",
      value: value ?? "",
      currencyCode: additionalValue2,
      telephoneCode: additionalData,
      countryCode: data,
    );
    return responseData;
  }

  ReceivingCountry toReceivingCountryForDashboard() {
    final responseData = ReceivingCountry(
      id: data ?? "",
      value: value ?? "",
      currencyCode: additionalValue2,
      telephoneCode: additionalData,
      countryCode: data,
    );
    return responseData;
  }

  Bank toBank() {
    final responseData = Bank(id: data ?? "", value: value ?? "", methodCode: additionalValue2 ?? "");
    return responseData;
  }

  Branch toBranch() {
    final responseData = Branch(id: data ?? "", value: value ?? "");
    return responseData;
  }

  PaymentMode toPaymentMode() {
    final responseData = PaymentMode(
      id: data ?? "",
      value: value ?? "",
      receiverCurrency: additionalValue3,
      paymentType: additionalValue,
    );
    return responseData;
  }

  States toStates() {
    final responseData = States(
      id: data ?? "",
      value: value ?? "",
    );
    return responseData;
  }

  DepositBank toDepositBankData() {
    final responseData = DepositBank(
      id: data ?? "",
      value: value ?? "",
      imageID: additionalValue2,
      accountno: accountNo,
      accountType: accountType,
      accountName: additionalValue,
      nativeAccountName: additionalValue2,
    );
    return responseData;
  }

  DepositType toDepositData() {
    final responseData = DepositType(
      id: data ?? "",
      value: value ?? "",
      imageID: additionalValue2,
      accountno: accountNo,
    );
    return responseData;
  }
}
