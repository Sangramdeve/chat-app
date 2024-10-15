class ApiException implements Exception {
  String? message;
  String prefix;

  ApiException([this.message, this.prefix = 'Error']);

  @override
  String toString() {
    return '$prefix $message';
  }
}

class TimeOutException extends ApiException {
  TimeOutException([String? message]) : super(message, 'Api TimeOut: ');
}

class NoInternetException extends ApiException {
  NoInternetException([String? message]) : super(message, 'No Internet Connection: ');
}

class FetchDataException extends ApiException {
  FetchDataException([String? message]) : super(message, 'Error During Communication: ');
}

class BadRequestException extends ApiException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorized: ');
}

class NotFoundException extends ApiException {
  NotFoundException([String? message]) : super(message, 'Not Found: ');
}

class ApiError extends ApiException {
  ApiError([String? message]) : super(message, 'API Error: ');
}

class ForbiddenException extends ApiException {
  ForbiddenException([String? message]) : super(message, 'Forbidden: ');
}

class ConflictException extends ApiException {
  ConflictException([String? message]) : super(message, 'Conflict: ');
}

class InternalServerException extends ApiException {
  InternalServerException([String? message]) : super(message, 'Internal Server Error: ');
}

class BadGatewayException extends ApiException {
  BadGatewayException([String? message]) : super(message, 'Bad Gateway: ');
}

class ServiceUnavailableException extends ApiException {
  ServiceUnavailableException([String? message]) : super(message, 'Service Unavailable: ');
}

class GatewayTimeoutException extends ApiException {
  GatewayTimeoutException([String? message]) : super(message, 'Gateway Timeout: ');
}
