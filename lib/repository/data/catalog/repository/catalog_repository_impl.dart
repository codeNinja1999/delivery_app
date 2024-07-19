import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/model/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/model/catalog_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_type_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalog_filter.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/repository/catalog_repository.dart';
import 'package:network/network.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'dart:convert';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({this.networkClient, this.userNetworkClient});

  NetworkClient? networkClient;
  NetworkClient? userNetworkClient;

  @override
  Future<Either<Exception, List<Country>>> fetchCountryList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.countryList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchIdIssueJurisdiction(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.idIssueJurisdiction.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Country>>> fetchCountrylanguage(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.countryList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueResponse) {
      return Right(catalogueResponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchOccupationList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.occupationList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchIncomeList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.incomeList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueResponse) {
      return Right(catalogueResponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<PostalAddress>>> fetchpostalCode(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.postalCode.value);
//postalcode
    final response = await fetchCatalog(requestData);
    return response.fold((error) {
      return Left(error);
    }, (catalogueResponse) {
      return Right(catalogueResponse.catalogueList?.map((item) => item.toPostCode()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchVisaList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.visaList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchreceiverType(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.receiverType.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<ReceivingCountry>>> fetchreceivingCountry(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.remitCountryList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toReceivingCountryData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchrelations(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.remitterRelation.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toBank()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<PaymentMode>>> fetchpaymentMode(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.paymentMode.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toPaymentMode()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<DepositType>>> fetchDepositMethodType(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.depositType.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toDepositData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchIdTypes(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.documentList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toBank()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchReceiverIdTypes(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.receiverIdType.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toBank()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Bank>>> fetchBankList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.bankList.value);
    final response = await fetchCatalog(requestData);
    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toBank()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Branch>>> fetchBranchList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.branchList.value);
    final response = await fetchCatalog(requestData);
    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toBranch()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<States>>> fetchStates(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.prefectureLis.value);
    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toStates()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchStreetType(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.streetType.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toDepositData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<DepositBank>>> fetchDepositBank(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.depositBank.value);
    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toDepositBankData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchRemittancePurpose(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.purposeOfRemittance.value);
    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toDomain()).toList() ?? []);
    });
  }

  Future<Either<Exception, CatalogResponseModel>> fetchCatalog(CatalogRequestModel requestModel) async {
    final requestQuery = requestModel.toJson();

    final endPoint = userNetworkClient != null ? AppServiceEndpoints.memberCatalogs : AppServiceEndpoints.catalogs;

    final newClient = networkClient ?? userNetworkClient;

    try {
      final reponse = await newClient?.get(endPoint, queryParameters: requestQuery);
      final responseJson = json.decode(reponse?.asString ?? "");
      final catalogueReponse = CatalogResponseModel.fromJson(responseJson);

      return Right(catalogueReponse);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, List<Catalog>>> fetchCityList(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.cityList.value);
    final response = await fetchCatalog(requestData);
    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toDepositData()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<ReceivingCountry>>> fetchreceivingCountryforDashboard(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.remitCountryList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueReponse) {
      return Right(catalogueReponse.catalogueList?.map((item) => item.toReceivingCountryForDashboard()).toList() ?? []);
    });
  }
}
