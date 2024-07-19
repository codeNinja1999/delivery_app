import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:network/network.dart';

class SignatureHelper {
  final String appKey;

  SignatureHelper(this.appKey);

  String signature(Object? requestBody) {
    final body = (requestBody != null && requestBody is! FormData) ? requestBody as String : "";
    final timeStapmp = Uri.encodeComponent('${DateTime.now().millisecondsSinceEpoch ~/ 1000}');

    final signatureValue = "$timeStapmp.$body.$appKey";
    final singnatureValueInBytes = utf8.encode(signatureValue);

    final signature = sha256.convert(singnatureValueInBytes).toString();
    final splitSignature = "$timeStapmp.$signature";

    return splitSignature;
  }
}
