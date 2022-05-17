class ServerException implements Exception {
  final message ;

  ServerException({this.message});
}

class CacheException implements Exception {}
