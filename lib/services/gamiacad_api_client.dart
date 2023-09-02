import 'dart:convert';

import 'package:http/http.dart' as http;

class GamiAcadAPIClient {
  static const _baseUrl = '172.31.58.135:8000';
  static const _baseHeaders = <String, String>{
    'Content-type': 'application/json',
    'Accept': '*/*',
    'clientId': '16785e25-688b-4e31-88bb-95b6ed588347'
  };

  static Future<http.Response> post({
    required String path,
    Map<String, String>? headers,
    Object? body,
    String? token,
  }) async {
    Uri url = Uri.http(
      _baseUrl,
      '/api$path',
    );

    return await http
        .post(
          url,
          headers: _configureHeaders(headers, token),
          body: json.encode(body),
        )
        .timeout(const Duration(seconds: 30));
  }

  static Map<String, String> _configureHeaders(
      Map<String, String>? headers, String? token) {
    Map<String, String> requestHeaders = headers ?? <String, String>{};
    requestHeaders.addAll(_baseHeaders);
    if (token != null) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }
    return requestHeaders;
  }
}
