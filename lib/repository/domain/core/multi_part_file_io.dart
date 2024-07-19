import 'package:http/http.dart';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'multi_part_file.dart';

Future<MultiPartFile> multipartFileFromPath(
  String field,
  String filePath, {
  String? filename,
  MediaType? contentType,
}) async {
  filename ??= p.basename(filePath);
  var file = File(filePath);
  var length = await file.length();
  var stream = ByteStream(file.openRead());
  return MultiPartFile(filePath, field, stream, length, filename: filename, contentType: contentType);
}
