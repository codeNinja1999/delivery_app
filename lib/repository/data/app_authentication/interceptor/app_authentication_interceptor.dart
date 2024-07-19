import 'dart:convert';
import 'dart:developer';
import 'package:fresh_fold_delivery/repository/repository.dart';

class AppAuthenticationInterceptor {
  AppAuthenticationInterceptor({
    required this.baseUrl,
    required this.signatureHelper,
  });

  final String baseUrl;
  final SignatureHelper signatureHelper;

  final appCredentialStorage = AppCredentialDataStore();

  Interceptor interceptor() {
    Map<String, String> headers(String processKey, String signature) => {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": processKey,
          "verify-signature": signature,
        };

    return Interceptor(onRequest: (request) async {
      final credential = await appCredentialStorage.getCredential();
      final newRequest = Request(
        headers: headers(credential.processKey, signatureHelper.signature(request.body)),
        queryParameters: request.queryParameters,
        method: request.method,
        url: URLProvider(baseUrl: baseUrl, path: request.url.toString()).url(),
        encoding: request.encoding,
        body: request.body,
      );
      log(name: "Actual url:", newRequest.url.toString());
      log(name: "Actual body:", newRequest.body.toString());
      return newRequest;
    }, onResponse: (apiResponse) async {
      log(name: "Actual Response:", apiResponse.asString);
      final responseJson = json.decode(apiResponse.asString);
      final response = ErrorDecodable.fromJson(responseJson);
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        if ((response.processResult == true)) {
          // if ((response.processResult == true) && (response.errorList?.isEmpty ?? true)) {
          return apiResponse;
        } else if (response.errorList?.first.errorCode == "force-logout") {
          throw (response.errorList?.first.errorMessage ?? "You have logged from new device.");
        } else {
          final errorMessage = response.errorList?.isNotEmpty ?? false
              ? response.errorList!.first.errorMessage ?? ""
              : "Something went wrong. Contact customer support.";
          throw Failure(errorMessage);
        }
      } else if (apiResponse.statusCode == 401) {
        final errorMessage = response.errorList?.isNotEmpty ?? false
            ? response.errorList!.first.errorMessage ?? ""
            : "Something went wrong. Contact customer support.";
        throw SessionExpired(errorMessage);
      } else {
        throw Failure(responseJson['Message'] ?? "Something went wrong. Contact customer support.");
      }
    });
  }
}
