import 'package:equatable/equatable.dart';

class Failure extends Equatable implements Exception {
  final String message;

  Failure({this.message = ""});

  @override
  List<Object> get props => [this.message];
}

class DeleteFailure extends Failure {
  DeleteFailure({String message = ""}) : super(message: message);
}

class GetFailure extends Failure {
  GetFailure({String message = ""}) : super(message: message);
}

class SaveFailure extends Failure {
  SaveFailure({String message = ""}) : super(message: message);
}

class UpdateFailure extends Failure {
  UpdateFailure({String message = ""}) : super(message: message);
}

class InvalidParameterFailure extends Failure {
  InvalidParameterFailure({String message = ""}) : super(message: message);
}

class EmptyDataFailure extends Failure {
  EmptyDataFailure({String message = ""}) : super(message: message);
}

class InvalidDataFailure extends Failure {
  InvalidDataFailure({String message = ""}) : super(message: message);
}

class GetListFailure extends Failure {
  GetListFailure({String message = ""}) : super(message: message);
}

class EmptyListFailure extends GetListFailure {
  EmptyListFailure({String message = ""}) : super(message: message);
}

class EmptyListSearchFailure extends GetListFailure {
  EmptyListSearchFailure({String message = ""}) : super(message: message);
}
