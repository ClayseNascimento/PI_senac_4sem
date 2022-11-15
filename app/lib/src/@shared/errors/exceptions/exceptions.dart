class Exception {
  final String? message;
  final Map<String, dynamic>? error;

  Exception({this.message, this.error});
}

class RemoteException extends Exception {
  final String? message;
  final Map<String, dynamic>? error;

  RemoteException({this.message, this.error}) : super(message: message, error: error);
}

class RemoteTimeoutException extends Exception {
  final String? message;
  final Map<String, dynamic>? error;

  RemoteTimeoutException({this.message, this.error}) : super(message: message, error: error);
}

class EmptyDataException extends Exception {
  final String? message;
  final Map<String, dynamic>? error;

  EmptyDataException({this.message, this.error}) : super(message: message, error: error);
}

class LocalException extends Exception {
  final String? message;
  final Map<String, dynamic>? error;

  LocalException({this.message, this.error}) : super(message: message, error: error);
}

class ServiceException extends Exception {
  final String? message;
  final Map<String, dynamic>? error;

  ServiceException({this.message, this.error}) : super(message: message, error: error);
}

