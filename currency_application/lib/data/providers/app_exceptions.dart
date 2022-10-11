

class AppException implements Exception {
  final String? message;
  final int? code;

  AppException([this.message, this.code]);

  @override
  String toString() {
    return 'AppException{_message: $message ?? ' ', _code: $code}';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message, code]) : super(message, code);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message);
}

class RequestCanceledException extends AppException {
  RequestCanceledException([String? message]) : super(message);
}

class ServerSideException extends AppException {
  ServerSideException([String? message]) : super(message);
}

class ConnectionException extends AppException {
  ConnectionException([String? message]) : super(message);
}
