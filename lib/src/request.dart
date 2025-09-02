import 'dart:convert';
import 'package:http/http.dart' as http;

/// Handles making HTTP requests to TheTVDB API.
class Request {
  final String _authToken;
  Map<String, dynamic>? _links;

  /// Creates a new Request instance with the provided authentication token.
  Request(this._authToken);

  /// Returns the links from the last response, if any.
  Map<String, dynamic>? get links => _links;

  /// Makes an HTTP GET request to the specified URL.
  ///
  /// [url] The URL to make the request to.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  ///
  /// Returns the response data as a dynamic type.
  /// Throws [Exception] if the request fails.
  Future<dynamic> makeRequest(
    String url, {
    String? ifModifiedSince,
  }) async {
    final headers = {
      'Authorization': 'Bearer $_authToken',
      if (ifModifiedSince != null) 'If-Modified-Since': ifModifiedSince,
    };

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 304) {
        return {
          'code': 304,
          'message': 'Not-Modified',
        };
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to get $url\n${data['message'] ?? 'Unknown error'}',
        );
      }

      _links = data['links'];
      return data['data'];
    } catch (e) {
      throw Exception('Request failed: $e');
    }
  }
}
