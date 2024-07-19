class URLProvider {
  URLProvider({required this.baseUrl, required this.path});
  final String baseUrl;
  final String path;

  Uri url() => Uri.parse(actualPath());

  String actualPath() {
    if (path.contains(baseUrl)) {
      return path;
    } else {
      return baseUrl + path;
    }
  }
}
