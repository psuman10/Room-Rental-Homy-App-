class HomyException implements Exception {
  final _message;

  HomyException([this._message]);

  @override
  String toString() {
    return '$_message';
  }
}

/// Server Exception
class ServerException extends HomyException {
  ServerException([message]) : super(message);
}

class EmptyDataException extends HomyException {
  EmptyDataException([String? message]) : super(message);
}

/// Server Exception
class CacheException extends HomyException {}
