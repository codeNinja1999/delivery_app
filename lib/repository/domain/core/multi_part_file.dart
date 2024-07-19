import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'multi_part_file_io.dart';

class MultiPartFile extends MultipartFile {
  final String filePath;

  MultiPartFile(
    this.filePath,
    String field,
    Stream<List<int>> stream,
    int length, {
    String? filename,
    MediaType? contentType,
  }) : super(field, stream, length, filename: filename, contentType: contentType);

  static Future<MultiPartFile> fromPath(String field, String filePath, {String? filename, MediaType? contentType}) =>
      multipartFileFromPath(field, filePath, filename: filename, contentType: contentType);

  /// Clone MultipartFile, returning a new instance of the same object.
  /// This is useful if your request failed and you wish to retry it,
  /// such as an unauthorized exception can be solved by refreshing the token.
  Future<MultiPartFile> clone() async {
    return MultiPartFile.fromPath(field, filePath);
  }
}
