class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException(
      [this._message,
      this._prefix]); //square brackets refer to positional optional params

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InternalServerError extends AppException {
  InternalServerError([String? message])
      : super(message, "Internal Server Error: ");
}
