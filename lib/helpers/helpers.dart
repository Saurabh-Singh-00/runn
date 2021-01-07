Uri constructUrlWithQueryParams(String baseUrl, String path, Map<dynamic, dynamic> queryParams) {
  Uri uri = Uri.http(baseUrl, path, queryParams);
  return uri;
}