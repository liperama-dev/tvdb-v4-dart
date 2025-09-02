/// Handles URL construction for TheTVDB API requests.
class Url {
  static const String _baseUrl = 'https://api4.thetvdb.com/v4/';

  /// Constructs a URL for TheTVDB API requests.
  ///
  /// [urlSect] The main URL section (e.g., 'series', 'movies').
  /// [urlId] Optional ID to append to the URL.
  /// [urlSubsect] Optional subsection to append to the URL.
  /// [urlLang] Optional language code to append to the URL.
  /// [query] Optional query parameters as a map.
  String construct(
    String urlSect, {
    dynamic urlId,
    String? urlSubsect,
    String? urlLang,
    Map<String, dynamic>? query,
  }) {
    final buffer = StringBuffer(_baseUrl)..write(urlSect);

    if (urlId != null) {
      buffer.write('/$urlId');
    }
    if (urlSubsect != null) {
      buffer.write('/$urlSubsect');
    }
    if (urlLang != null) {
      buffer.write('/$urlLang');
    }

    if (query != null && query.isNotEmpty) {
      final params = <String, String>{};
      query.forEach((key, value) {
        if (value != null) {
          params[key] = value.toString();
        }
      });
      
      if (params.isNotEmpty) {
        buffer.write('?');
        buffer.write(
          params.entries
              .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
              .join('&'),
        );
      }
    }

    return buffer.toString();
  }
}
