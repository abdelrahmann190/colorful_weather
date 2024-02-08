class ServerException implements Exception {}

class CacheException implements Exception {}

class LocationException implements Exception {
  final String? message;

  LocationException({this.message});
}
