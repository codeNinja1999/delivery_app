import 'dart:io';
import 'package:fresh_fold_delivery/repository/repository.dart';

extension MapExtension on Map<String, dynamic> {
  Future<FormData> toMultipartFile() async {
    List<MultiPartFile> files = [];
    Map<String, String> fields = {};

    for (var key in keys) {
      if (this[key] is File) {
        ///
        /// Make sure you use [MultiPartFile] instead of default http.MultipartFile when making Initial Request
        /// MultiPartFile is extended type of http.MultipartFile
        ///
        final value = await MultiPartFile.fromPath(key, this[key].path);
        files.add(value);
      } else {
        fields[key] = this[key].toString();
      }
    }
    return FormData.from(fields: fields, files: files);
  }
}
