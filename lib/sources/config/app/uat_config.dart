import 'app.dart';

AppConfig uatConfig(String version) => AppConfig(
      flavor: AppFlavour.uat,
      baseUrl: "http://52.44.104.77:8000/api/",
      imageBaseUlr: "https://uatinceptionblobstorage.blob.core.windows.net/transactiondocuments/",
      appKey: "8sjdoijfoijsdfsf",
      version: version,
    );
