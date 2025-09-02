import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:tvdb_v4_dart/tvdb_v4_dart.dart';

// Mock classes for dependencies
class MockUrl extends Mock implements Url {
  @override
  String construct(
    String path, {
    Map<String, dynamic>? query,
    dynamic urlId,
    String? urlLang,
    String? urlSubsect,
  }) {
    final queryParams =
        query?.entries.map((e) => '${e.key}=${e.value}').join('&');
    final baseUrl = 'https://api4.thetvdb.com/v4/$path';
    return queryParams != null ? '$baseUrl?$queryParams' : baseUrl;
  }
}

class MockRequest extends Mock implements Request {
  @override
  Future<dynamic> makeRequest(
    String url, {
    String? ifModifiedSince,
  }) async {
    return super.noSuchMethod(
      Invocation.method(
        #makeRequest,
        [url],
        {#ifModifiedSince: ifModifiedSince},
      ),
    );
  }
}

class MockAuth extends Mock implements Auth {
  @override
  String get token => 'test_token';
}

void main() {
  late MockUrl mockUrl;
  late MockRequest mockRequest;
  late MockAuth mockAuth;

  const apiKey = 'test_api_key';
  const pin = 'test_pin';
  const token = 'test_token';

  setUp(() {
    mockUrl = MockUrl();
    mockRequest = MockRequest();
    mockAuth = MockAuth();

    // Setup default mock behaviors
    registerFallbackValue(mockUrl);
    registerFallbackValue(mockRequest);
    registerFallbackValue(mockAuth);
  });

  group('TVDB', () {
    test('should create instance with factory method', () async {
      // Arrange
      when(() => mockUrl.construct('login'))
          .thenReturn('https://api4.thetvdb.com/v4/login');

      // Mock Auth.create
      when(() => Auth.create(
            'https://api4.thetvdb.com/v4/login',
            apiKey,
            pin: pin,
          )).thenAnswer((_) async => mockAuth);

      // Mock Request constructor
      when(() => Request(token)).thenReturn(mockRequest);

      // Act
      final tvdb = await TVDB.create(apiKey, pin: pin);

      // Assert
      expect(tvdb, isA<TVDB>());
      verify(() => mockUrl.construct('login')).called(1);
      verify(() => Auth.create(
            'https://api4.thetvdb.com/v4/login',
            apiKey,
            pin: pin,
          )).called(1);
      verify(() => Request(token)).called(1);
    });

    test('should handle authentication failure', () async {
      // Arrange
      when(() => mockUrl.construct('login'))
          .thenReturn('https://api4.thetvdb.com/v4/login');

      // Mock Auth.create to throw an exception
      when(() => Auth.create(
            'https://api4.thetvdb.com/v4/login',
            apiKey,
            pin: pin,
          )).thenThrow(Exception('Authentication failed'));

      // Act & Assert
      expect(
        () => TVDB.create(apiKey, pin: pin),
        throwsA(isA<Exception>()),
      );
    });
  });
}
