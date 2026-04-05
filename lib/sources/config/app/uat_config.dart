import 'app.dart';

AppConfig uatConfig(String version) => AppConfig(
      flavor: AppFlavour.uat,
      baseUrl: "http://64.120.92.219:7007/api/",
      imageBaseUlr: "",
      appKey: "8sjdoijfoijsdfsf",
      version: version,
    );
