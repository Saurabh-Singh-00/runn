

class APIException implements Exception {
  final String message;
  final int statusCode;

  APIException(this.message, this.statusCode);
}

class ResultNotFoundException extends APIException {
  final String message;
  final int statusCode;

  ResultNotFoundException(this.message, this.statusCode) : super(message, statusCode);

  @override
  String toString() {
    return "${this.runtimeType}: ${this.message}";
  }
}

class CreationFailedException extends APIException {
  final String message;
  final int statusCode;

  CreationFailedException(this.message, this.statusCode) : super(message, statusCode);

  @override
  String toString() {
    return "${this.runtimeType}: ${this.message}";
  }
}

class UpdateFailedException extends APIException {
  final String message;
  final int statusCode;

  UpdateFailedException(this.message, this.statusCode) : super(message, statusCode);

  @override
  String toString() {
    return "${this.runtimeType}: ${this.message}";
  }
}

class DeletionFailedException extends APIException {
  final String message;
  final int statusCode;

  DeletionFailedException(this.message, this.statusCode) : super(message, statusCode);

  @override
  String toString() {
    return "${this.runtimeType}: ${this.message}";
  }
}
