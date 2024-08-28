import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import 'package:fresh_fold_delivery/repository/data/user/data_store/user_credential_data.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'dart:collection';

final Queue<Completer<bool>> _tokenRefreshQueue = Queue<Completer<bool>>();

class UserAuthenticationInterceptor {
  UserAuthenticationInterceptor({
    required this.baseUrl,
    // required this.signatureHelper,
    required this.userAuthenticationRepository,
  });

  final String baseUrl;
  final userCredentialDataStore = UserCredentialDataStore();
  // final SignatureHelper signatureHelper;
  UserAuthenticationRepository userAuthenticationRepository;

  Map<String, String> generateHeaders(
    String accessToken,
    // String signature,
  ) =>
      {
        "Authorization": accessToken,
        "Accept": "application/json",
        "Content-Type": "application/json",
        // "verify-signature": signature,
      };

  Interceptor interceptor() {
    return Interceptor(onRequest: (request) async {
      final credential = await userCredentialDataStore.getCredential();
      final String accessToken = "${credential?.tokenType ?? "Bearer"} ${credential?.accessToken ?? ""}";
      final headers = generateHeaders(
        accessToken,
        // signatureHelper.signature(request.body),
      );
      final finalHeader = <String, String>{}
        ..addAll(headers)
        ..addAll(request.headers);
      if (request.body is FormData) {
        headers.addAll({'X-Requested-With': 'XMLHttpRequest'});
      }
      final newRequest = Request(
        headers: finalHeader,
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
      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return apiResponse;
      } else if (apiResponse.statusCode == 401) {
        throw SessionExpired("Session expired");
      } else {
        final apiResponseString = apiResponse.asString;

        if (apiResponseString.isEmpty) {
          throw Exception("Something went wrong. Contact customer support.");
        } else {
          // Proceed with processing the response
            final responseJson = json.decode(apiResponseString);
            final errorMessage = responseJson['message'];
            throw Exception(errorMessage);

        }
      }
    });
  }

  void refreshToken() async {
    final response = await userAuthenticationRepository.refreshUserToken();
    response.fold((error) {
      final completer = _tokenRefreshQueue.removeFirst();
      completer.completeError(error);
      _tokenRefreshQueue.clear();
    }, (right) {
      while (_tokenRefreshQueue.isNotEmpty) {
        final completer = _tokenRefreshQueue.removeFirst();
        completer.complete(true);
      }
    });
  }

  Future<Response> recall(Request request) async {
    final credential = await userCredentialDataStore.getCredential();
    final String accessToken = "${credential?.tokenType ?? "Bearer"} ${credential?.accessToken ?? ""}";
    var headers = request.headers;
    headers['Authorization'] = accessToken;
    // final headers = generateHeaders(accessToken);

    late Object? body;
    if (request.body is FormData) {
      final requestBody = request.body as FormData;

      final files = await Future.wait(requestBody.files.map((item) async {
        /// Checks if it is Extended MultiPartFile for Cloning
        ///
        /// Clones the Existing finalized MultipartFile and recreate new object for retrying
        ///
        /// Make sure you use [MultiPartFile] instead of default http MultipartFile when making Initial Request
        /// Can be crashed if initial request is not Expected type [MultiPartFile]
        ///
        final multiPartFile = item as MultiPartFile;
        return await multiPartFile.clone();
      }).toList());

      body = FormData.from(fields: requestBody.fields, files: files);
    } else {
      body = request.body;
    }

    final NetworkClient nettworkClient = NetworkClient();
    final response = await nettworkClient.send(
      request.url,
      method: request.method,
      headers: headers,
      body: body,
      queryParameters: request.queryParameters,
    );
    print("Recall responseCode: ${response.statusCode}");
    //Error handling required
    if (response.statusCode == 401) {}
    return response;
  }
}
