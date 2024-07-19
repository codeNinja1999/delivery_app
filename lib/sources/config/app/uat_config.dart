import 'app.dart';

AppConfig uatConfig(String version) => AppConfig(
      flavor: AppFlavour.uat,
      baseUrl: "https://remitxakbar.iremit.com.my/MobileApi/v1/",
      imageBaseUlr: "https://uatinceptionblobstorage.blob.core.windows.net/transactiondocuments/",
      appKey: "8sjdoijfoijsdfsf",
      version: version,
    );
