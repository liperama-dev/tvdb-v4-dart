# tvdb_v4_dart

This package strives to be as close as possible to a direct Dart translation of the official [TVDB](https://thetvdb.com/) API v4 [Python package](https://github.com/thetvdb/tvdb-v4-python).

Each one of this package's API wrapper methods have the same signatures as their counterparts in the official client.

Please see the [Differences from the Official Python Client](#differences-from-the-official-python-client) section for more information on this translation's particularities.

## Features

- Complete implementation of TheTVDB API v4
- Type-safe Dart code with null safety
- Asynchronous API using Dart's `Future` and `async`/`await`
- Direct translation from the official Python client

# Versioning

This project follows standard semantic versioning (SemVer).

Major and minor versions reflect the major and minor versions of the official client on which this translation is based.

Patch versions are independent from the official client and are reserved for Dart-specific changes, such as adding null safety, refactoring, or translation corrections.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  tvdb_v4_dart: ^1.1.0
```

Then run:

```bash
flutter pub get
# or
pub get
```

## Differences from the Official Python Client

1. **Asynchronous API**:
   - The Dart version uses `async`/`await` pattern throughout the codebase
   - All methods return `Future<T>` instead of direct values
   - Uses Dart's built-in `http` package for network requests

2. **Type System**:
   - Leverages Dart's strong type system with null safety
   - Returns `Map<String, dynamic>` for JSON responses instead of custom objects
   - Uses Dart's built-in types (e.g., `List` instead of Python's `list`)

3. **Authentication**:
   - Implements the same OAuth2 flow but with Dart's `http` client
   - Token management is handled internally but follows the same expiration logic

4. **Error Handling**:
   - Uses Dart's `Exception` class for error handling
   - Error messages are preserved but formatted for Dart conventions

5. **Dependencies**:
   - No external dependencies beyond Dart's core libraries
   - Uses `http` package for network requests (included in Flutter)

## Usage
### Authentication

To use this library, you'll need an API key from TheTVDB. You can get one by signing up at [TheTVDB API](https://thetvdb.com/api-information).

### Example

```dart
import 'package:tvdb_v4_dart/tvdb_v4_dart.dart';

void main() async {
  // Create a new TVDB client
  final tvdb = await TVDB.create('YOUR_API_KEY');
  
  try {
    // Get a list of all series
    final series = await tvdb.getAllSeries();
    print('Found ${series.length} series');
    
    // Get details for a specific series
    final firstSeriesId = series.first['id'] as int;
    final seriesDetails = await tvdb.getSeries(firstSeriesId);
    print('First series: ${seriesDetails['name']}');
    
    // Get extended information for a series
    final seriesExtended = await tvdb.getSeriesExtended(firstSeriesId);
    print('Genres: ${seriesExtended['genres']?.join(', ')}');
    
  } catch (e) {
    print('Error: $e');
  }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
