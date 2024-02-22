class AppException implements Exception {
  final Object? message;
  final int? statusCode;
  final String? url;

  AppException([this.message, this.statusCode, this.url]);
  @override
  String toString() {
    return message.toString();
  }
}

class BadRequestException extends AppException {
  BadRequestException([Object? message, int? statusCode])
      : super(message ?? 'Bad request', statusCode);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, int? statusCode])
      : super(message ?? 'Unable to fetch data', statusCode);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, int? statusCode])
      : super(message ?? 'API not responding', statusCode);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, int? statusCode])
      : super(message ?? 'Unauthorized request', statusCode);
}

class NotFoundException extends AppException {
  NotFoundException([String? message, int? statusCode])
      : super(message ?? 'Not found', statusCode);
}

class ServerErrorException extends AppException {
  ServerErrorException([String? message, int? statusCode])
      : super(message ?? 'Server error', statusCode);
}

class GatewayTimeoutException extends AppException {
  GatewayTimeoutException([String? message, int? statusCode])
      : super(message ?? 'Gateway timeout', statusCode);
}

class NoInternetException extends AppException {
  NoInternetException([String? message, int? statusCode])
      : super(message ?? 'Please check your internet connection and try again',
            statusCode);
}

class AppTimeoutException extends AppException {
  static const defaultMessage =
      'Request Timed Out. Please check your internet connection and try again.';

  AppTimeoutException([String? customMessage, int? statusCode])
      : super(customMessage ?? defaultMessage, statusCode);
}
