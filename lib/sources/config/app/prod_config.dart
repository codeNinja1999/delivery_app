import 'app.dart';

AppConfig productionConfig(String version) => AppConfig(
      flavor: AppFlavour.production,
      baseUrl: "https://remitxakbar.iremit.com.my:65000/MobileApi/v1/",
      imageBaseUlr: "https://uatinceptionblobstorage.blob.core.windows.net/transactiondocuments/",
      appKey: "8sjdoijfoijsdfsf",
      version: version,
    );
