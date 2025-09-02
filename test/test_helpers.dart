import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends http.Response {
  MockResponse(
    super.body,
    super.statusCode, {
    Map<String, String>? headers,
  }) : super(
          headers: headers ?? {'content-type': 'application/json'},
          request: null,
        );
}

class MockStreamedResponse extends http.StreamedResponse {
  MockStreamedResponse(
    super.stream,
    super.statusCode, {
    Map<String, String>? headers,
  }) : super(
          request: null,
          headers: headers ?? {'content-type': 'application/json'},
          isRedirect: false,
          persistentConnection: true,
          reasonPhrase: 'OK',
        );
}

class MockHttpClientHandler {
  final Map<Uri, http.Response> responses = {};
  final Map<Uri, http.StreamedResponse> streamedResponses = {};

  void addResponse(
    String url,
    dynamic body, {
    int statusCode = 200,
    Map<String, String>? headers,
  }) {
    final uri = Uri.parse(url);
    final response = MockResponse(
      body is String ? body : jsonEncode(body),
      statusCode,
      headers: headers,
    );
    responses[uri] = response;
  }

  void addStreamedResponse(
    String url,
    String body, {
    int statusCode = 200,
    Map<String, String>? headers,
  }) {
    final uri = Uri.parse(url);
    final stream = Stream.value(Uint8List.fromList(utf8.encode(body)));
    final response = MockStreamedResponse(
      stream,
      statusCode,
      headers: headers,
    );
    streamedResponses[uri] = response;
  }

  void setupMockClient(MockHttpClient client) {
    // Setup get
    when(() => client.get(any(),
            headers: any(named: 'headers'))) // ignore: deprecated_member_use
        .thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.first as Uri;
      if (responses.containsKey(uri)) {
        return responses[uri]!;
      }
      return MockResponse('Not Found', 404);
    });

    // Setup post
    when(() => client.post(any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
        encoding: any(named: 'encoding'))).thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.first as Uri;
      if (responses.containsKey(uri)) {
        return responses[uri]!;
      }
      return MockResponse('Not Found', 404);
    });

    // Setup put
    when(() => client.put(any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
        encoding: any(named: 'encoding'))).thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.first as Uri;
      if (responses.containsKey(uri)) {
        return responses[uri]!;
      }
      return MockResponse('Not Found', 404);
    });

    // Setup delete
    when(() => client.delete(any(),
        headers: any(named: 'headers'),
        body: any(named: 'body'),
        encoding: any(named: 'encoding'))).thenAnswer((invocation) async {
      final uri = invocation.positionalArguments.first as Uri;
      if (responses.containsKey(uri)) {
        return responses[uri]!;
      }
      return MockResponse('Not Found', 404);
    });

    // Setup send
    when(() => client.send(any())).thenAnswer((invocation) async {
      final request = invocation.positionalArguments.first as http.Request;
      final uri = request.url;

      if (streamedResponses.containsKey(uri)) {
        return streamedResponses[uri]!;
      }

      if (responses.containsKey(uri)) {
        final response = responses[uri]!;
        final stream = http.ByteStream.fromBytes(utf8.encode(response.body));
        return http.StreamedResponse(
          stream,
          response.statusCode,
          contentLength: response.contentLength,
          request: request,
          headers: response.headers,
          isRedirect: response.isRedirect,
          persistentConnection: true,
          reasonPhrase: 'OK',
        );
      }

      final stream = http.ByteStream.fromBytes(utf8.encode('Not Found'));
      return http.StreamedResponse(
        stream,
        404,
        contentLength: 9,
        request: request,
        headers: {'content-type': 'text/plain'},
        isRedirect: false,
        persistentConnection: true,
        reasonPhrase: 'Not Found',
      );
    });
  }
}

/// Creates a mock HTTP response with the given [body] and [statusCode].
http.Response createMockResponse(dynamic body, int statusCode) {
  if (body is Map<String, dynamic> || body is List) {
    return MockResponse(
      jsonEncode(body),
      statusCode,
      headers: {'content-type': 'application/json'},
    );
  } else if (body is String) {
    return MockResponse(
      body,
      statusCode,
      headers: {'content-type': 'application/json'},
    );
  } else {
    throw ArgumentError('Unsupported body type: ${body.runtimeType}');
  }
}

/// Creates a mock HTTP client with the given responses.
MockHttpClient createMockHttpClient({
  Map<String, dynamic>? getResponses,
  Map<String, dynamic>? postResponses,
  Map<String, dynamic>? putResponses,
  Map<String, dynamic>? deleteResponses,
}) {
  final client = MockHttpClient();
  final handler = MockHttpClientHandler();

  // Add responses for each method
  if (getResponses != null) {
    getResponses.forEach((url, response) {
      if (response is Map || response is List) {
        handler.addResponse(url, response);
      } else if (response is String) {
        handler.addResponse(url, response);
      } else if (response is http.Response) {
        handler.responses[Uri.parse(url)] = response;
      }
    });
  }

  if (postResponses != null) {
    postResponses.forEach((url, response) {
      if (response is Map || response is List) {
        handler.addResponse(url, response);
      } else if (response is String) {
        handler.addResponse(url, response);
      } else if (response is http.Response) {
        handler.responses[Uri.parse(url)] = response;
      }
    });
  }

  if (putResponses != null) {
    putResponses.forEach((url, response) {
      if (response is Map || response is List) {
        handler.addResponse(url, response);
      } else if (response is String) {
        handler.addResponse(url, response);
      } else if (response is http.Response) {
        handler.responses[Uri.parse(url)] = response;
      }
    });
  }

  if (deleteResponses != null) {
    deleteResponses.forEach((url, response) {
      if (response is Map || response is List) {
        handler.addResponse(url, response);
      } else if (response is String) {
        handler.addResponse(url, response);
      } else if (response is http.Response) {
        handler.responses[Uri.parse(url)] = response;
      }
    });
  }

  // Setup the mock client with the handler
  handler.setupMockClient(client);
  return client;
}
