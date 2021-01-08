Uri constructUrlWithQueryParams(String baseUrl, String path, Map<dynamic, dynamic> queryParams) {
  Uri uri;
  if(queryParams.isEmpty) {
    uri = Uri.http(baseUrl, path);
  }
  else {
    uri = Uri.http(baseUrl, path, queryParams);
  }
  return uri;
}