class GraphQLException implements Exception {
  final String? message;
  final String? error;
  final int? statusCode;

  const GraphQLException(this.message, this.error, this.statusCode);

  @override
  String toString() {
    return message ?? "An unexpected error occurred";
  }
}

class FetchDataException extends GraphQLException {
  const FetchDataException(
    String message,
  ) : super(message, null, null);
  @override
  String toString() {
    return message!;
  }
}

class InternalServerException extends GraphQLException {
  const InternalServerException(String message, int? statusCode)
      : super(message, null, statusCode);
  @override
  String toString() {
    return message!;
  }
}

class BadRequestException extends GraphQLException {
  const BadRequestException(String message, String error, int statusCode)
      : super(message, error, statusCode);
  @override
  String toString() {
    return message!;
  }
}

class UnAuthorizedException extends GraphQLException {
  const UnAuthorizedException(String message, String? error, int? statusCode)
      : super(message, error, statusCode);
  @override
  String toString() {
    return message!;
  }
}

class NotFoundException extends GraphQLException {
  const NotFoundException(String message, int? statusCode)
      : super(message, null, statusCode);
  @override
  String toString() {
    return message!;
  }
}
