import 'auth.dart';
import 'request.dart';
import 'url.dart';

/// The main client for interacting with TheTVDB API v4.
class TVDB {
  final Url _url;
  final Request _request;

  /// Creates a new TVDB client instance.
  ///
  /// [apiKey] Your TheTVDB API key.
  /// [pin] Optional PIN for additional authentication.
  /// 
  /// Throws an [Exception] if authentication fails.
  static Future<TVDB> create(String apiKey, {String pin = ''}) async {
    final url = Url();
    final loginUrl = url.construct('login');
    final auth = await Auth.create(loginUrl, apiKey, pin: pin);
    return TVDB._(url, Request(auth.token));
  }
  
  /// Private constructor used by the factory.
  TVDB._(this._url, this._request);

  /// Returns the links from the last response, if any.
  Map<String, dynamic>? get links => _request.links;

  // Artwork methods
  
  /// Returns a list of artwork statuses.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getArtworkStatuses({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'artwork/statuses',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a list of artwork types.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getArtworkTypes({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'artwork/types',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns an artwork by ID.
  /// 
  /// [id] The artwork ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getArtwork(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'artwork',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for an artwork by ID.
  /// 
  /// [id] The artwork ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getArtworkExtended(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'artwork',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Awards methods
  
  /// Returns a list of all awards.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllAwards({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'awards',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns an award by ID.
  /// 
  /// [id] The award ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getAward(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'awards',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for an award by ID.
  /// 
  /// [id] The award ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getAwardExtended(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'awards',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a list of all award categories.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllAwardCategories({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'awards/categories',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns an award category by ID.
  /// 
  /// [id] The award category ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getAwardCategory(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'awards/categories',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for an award category by ID.
  /// 
  /// [id] The award category ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getAwardCategoryExtended(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'awards/categories',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Content Ratings methods
  
  /// Returns a list of all content ratings.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getContentRatings({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'content/ratings',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Countries methods
  
  /// Returns a list of all countries.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getCountries({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'countries',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Companies methods
  
  /// Returns a list of all companies.
  /// 
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllCompanies({
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'companies',
      query: _buildQuery(meta: meta, page: page),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a list of company types.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getCompanyTypes({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'companies/types',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a company by ID.
  /// 
  /// [id] The company ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getCompany(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'companies',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Series methods
  
  /// Returns a list of all series.
  /// 
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllSeries({
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'series',
      query: _buildQuery(meta: meta, page: page),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a series by ID.
  /// 
  /// [id] The series ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getSeries(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'series',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a series by slug.
  /// 
  /// [slug] The series slug.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getSeriesBySlug(
    String slug, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'series/slug',
      urlId: slug,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for a series by ID.
  /// 
  /// [id] The series ID.
  /// [meta] Optional metadata to include in the response.
  /// [short] Whether to return a short version of the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getSeriesExtended(
    int id, {
    String? meta,
    bool short = false,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'series',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta, short: short),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Episodes methods
  
  /// Returns a list of all episodes.
  /// 
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllEpisodes({
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'episodes',
      query: _buildQuery(meta: meta, page: page),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns an episode by ID.
  /// 
  /// [id] The episode ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getEpisode(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'episodes',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for an episode by ID.
  /// 
  /// [id] The episode ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getEpisodeExtended(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'episodes',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Movies methods
  
  /// Returns a list of all movies.
  /// 
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllMovies({
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'movies',
      query: _buildQuery(meta: meta, page: page),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a movie by ID.
  /// 
  /// [id] The movie ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getMovie(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'movies',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a movie by slug.
  /// 
  /// [slug] The movie slug.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getMovieBySlug(
    String slug, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'movies/slug',
      urlId: slug,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for a movie by ID.
  /// 
  /// [id] The movie ID.
  /// [meta] Optional metadata to include in the response.
  /// [short] Whether to return a short version of the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getMovieExtended(
    int id, {
    String? meta,
    bool short = false,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'movies',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta, short: short),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Seasons methods
  
  /// Returns a list of all seasons.
  /// 
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllSeasons({
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'seasons',
      query: _buildQuery(meta: meta, page: page),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a season by ID.
  /// 
  /// [id] The season ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getSeason(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'seasons',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for a season by ID.
  /// 
  /// [id] The season ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getSeasonExtended(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'seasons',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a list of season types.
  /// 
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getSeasonTypes({
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'seasons/types',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // People methods
  
  /// Returns a list of all people.
  /// 
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<List<dynamic>> getAllPeople({
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'people',
      query: _buildQuery(meta: meta, page: page),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a person by ID.
  /// 
  /// [id] The person ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getPerson(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'people',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns extended information for a person by ID.
  /// 
  /// [id] The person ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getPersonExtended(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'people',
      urlId: id,
      urlSubsect: 'extended',
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Returns a character by ID.
  /// 
  /// [id] The character ID.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> getCharacter(
    int id, {
    String? meta,
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'characters',
      urlId: id,
      query: _buildQuery(meta: meta),
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Search methods
  
  /// Searches for entities based on a query.
  /// 
  /// [query] The search query.
  /// [year] Filter results by year.
  /// [company] Filter results by company.
  /// [country] Filter results by country.
  /// [director] Filter results by director.
  /// [language] Filter results by language.
  /// [primaryType] Filter results by primary type.
  /// [status] Filter results by status.
  /// [sort] Sort order for results.
  /// [sortType] Sort type (asc or desc).
  /// [page] The page number to return.
  /// [meta] Optional metadata to include in the response.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> search(
    String query, {
    int? year,
    String? company,
    String? country,
    String? director,
    String? language,
    String? primaryType,
    String? status,
    String? sort,
    String? sortType,
    int? page,
    String? meta,
    String? ifModifiedSince,
  }) async {
    final queryParams = <String, dynamic>{
      'query': query,
      if (year != null) 'year': year,
      if (company != null) 'company': company,
      if (country != null) 'country': country,
      if (director != null) 'director': director,
      if (language != null) 'lang': language,
      if (primaryType != null) 'primaryType': primaryType,
      if (status != null) 'status': status,
      if (sort != null) 'sort': sort,
      if (sortType != null) 'sortType': sortType,
      if (page != null) 'page': page,
      if (meta != null) 'meta': meta,
    };

    final url = _url.construct(
      'search',
      query: queryParams,
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  /// Searches for entities by remote ID.
  /// 
  /// [remoteId] The remote ID to search for.
  /// [ifModifiedSince] Optional If-Modified-Since header value.
  Future<Map<String, dynamic>> searchByRemoteId(
    String remoteId, {
    String? ifModifiedSince,
  }) async {
    final url = _url.construct(
      'search/remoteid/$remoteId',
    );
    return await _request.makeRequest(url, ifModifiedSince: ifModifiedSince);
  }

  // Helper methods
  
  Map<String, dynamic> _buildQuery({
    String? meta,
    int? page,
    bool? short,
  }) {
    final query = <String, dynamic>{};
    if (meta != null) query['meta'] = meta;
    if (page != null) query['page'] = page;
    if (short != null) query['short'] = short;
    return query;
  }
}
