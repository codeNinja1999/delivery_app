import 'dart:convert';
import 'dart:io';

import 'package:fresh_fold_delivery/repository/domain/core/core.dart';
import 'package:network/network.dart';

extension MapExtension on Map<String, dynamic> {
  Future<FormData> toMultipartFile() async {
    List<MultiPartFile> files = [];
    Map<String, String> fields = {};

    for (var key in keys) {
      final value = this[key];

      if (this[key] is File) {
        ///
        /// Make sure you use [MultiPartFile] instead of default http.MultipartFile when making Initial Request
        /// MultiPartFile is extended type of http.MultipartFile
        ///
        final value = await MultiPartFile.fromPath(key, this[key].path);
        files.add(value);
      } else if (value is String && (value.startsWith('data:image') || value.contains('/9'))) {
        final bytes = base64Decode(value);

        final file = await MultiPartFile.fromBytes(key, bytes);
        files.add(file);
      } else {
        if (this[key]?.toString() != null) {
          fields[key] = this[key].toString();
        }
      }
    }
    return FormData.from(fields: fields, files: files);
  }
}
