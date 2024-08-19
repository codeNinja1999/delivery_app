import 'dart:convert';
import 'dart:developer';
import 'package:network/network.dart';

import 'package:fresh_fold_delivery/repository/data/core/url_provider.dart';
import 'package:fresh_fold_delivery/repository/domain/core/core.dart';

class DefaultInterceptor {
  DefaultInterceptor({required this.baseUrl});
  final String baseUrl;

  Interceptor interceptor() {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    return Interceptor(onRequest: (request) async {
      final finalHeader = <String, String>{}
        ..addAll(headers)
        ..addAll(request.headers);

      final newRequest = Request(
        headers: finalHeader,
        queryParameters: request.queryParameters,
        method: request.method,
        url: URLProvider(baseUrl: baseUrl, path: request.url.toString()).url(),
        encoding: Encoding.getByName("utf-8"),
        body: request.body,
      );

      log(name: "Actual url:", newRequest.url.toString());
      log(name: "Actual body:", newRequest.body.toString());
      return newRequest;
    }, onResponse: (apiResponse) async {
      log(name: "Actual Response:", apiResponse.asString);
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return apiResponse;
      } else if (apiResponse.statusCode == 401) {
        throw SessionExpired("Session expired");
      } else {
        throw Exception("Something went wrong. Contact customer support.");
      }
    });
  }
}
