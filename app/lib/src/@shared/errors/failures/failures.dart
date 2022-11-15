class Failure {
  final String? message;

  Failure({this.message});
}

class DeleteFailure extends Failure {
  final String? message;

  DeleteFailure({this.message}) : super(message: message);
}

class GetFailure extends Failure {
  final String? message;

  GetFailure({this.message}) : super(message: message);
}

class SaveFailure extends Failure {
  final String? message;

  SaveFailure({this.message}) : super(message: message);
}

class UpdateFailure extends Failure {
  final String? message;

  UpdateFailure({this.message}) : super(message: message);
}

class InvalidParameterFailure extends Failure {
  final String? message;

  InvalidParameterFailure({this.message}) : super(message: message);
}

class InvalidDataFailure extends Failure {
  final String? message;

  InvalidDataFailure({this.message}) : super(message: message);
}

class EmptyDataFailure extends Failure {
  final String? message;

  EmptyDataFailure({this.message}) : super(message: message);
}

class GetListFailure extends Failure {
  final String? message;

  GetListFailure({this.message}) : super(message: message);
}

class EmptyListFailure extends Failure {
  final String? message;

  EmptyListFailure({this.message}) : super(message: message);
}

class TimeoutFailure extends Failure {
  final String? message;

  TimeoutFailure({this.message}) : super(message: message);
}
