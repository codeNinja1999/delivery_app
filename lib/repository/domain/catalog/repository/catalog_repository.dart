import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class CatalogRepository {
  Future<Either<Exception, List<Country>>> fetchCountrylanguage(CatalogFilter filter);
  Future<Either<Exception, List<Country>>> fetchCountryList(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchOccupationList(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchIncomeList(CatalogFilter filter);
  Future<Either<Exception, List<ReceivingCountry>>> fetchreceivingCountry(CatalogFilter filter);
  Future<Either<Exception, List<ReceivingCountry>>> fetchreceivingCountryforDashboard(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchIdTypes(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchReceiverIdTypes(CatalogFilter filter);
  Future<Either<Exception, List<DepositType>>> fetchDepositMethodType(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchrelations(CatalogFilter filter);
  Future<Either<Exception, List<Bank>>> fetchBankList(CatalogFilter filter);
  Future<Either<Exception, List<Branch>>> fetchBranchList(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchVisaList(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchreceiverType(CatalogFilter filter);
  Future<Either<Exception, List<PaymentMode>>> fetchpaymentMode(CatalogFilter filter);
  Future<Either<Exception, List<PostalAddress>>> fetchpostalCode(CatalogFilter filter);
  Future<Either<Exception, List<States>>> fetchStates(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchCityList(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchStreetType(CatalogFilter filter);
  Future<Either<Exception, List<DepositBank>>> fetchDepositBank(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchRemittancePurpose(CatalogFilter filter);
  Future<Either<Exception, List<Catalog>>> fetchIdIssueJurisdiction(CatalogFilter filter);
}
