import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Handles authentication with TheTVDB API.
class Auth {
  final String _token;

  /// Creates a new Auth instance by authenticating with the provided API key and optional PIN.
  ///
  /// Throws an [Exception] if authentication fails.
  static Future<Auth> create(String url, String apiKey, {String pin = ''}) async {
    final loginInfo = <String, String>{'apikey': apiKey};
    if (pin.isNotEmpty) {
      loginInfo['pin'] = pin;
    }

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(loginInfo);
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return Auth._(data['data']['token'] as String);
      } else {
        final error = jsonDecode(response.body) as Map<String, dynamic>;
        throw Exception('Code: ${response.statusCode}, ${error['message']}');
      }
    } catch (e) {
      throw Exception('Failed to authenticate: $e');
    }
  }

  const Auth._(this._token);

  /// Returns the authentication token.
  String get token => _token;
}
