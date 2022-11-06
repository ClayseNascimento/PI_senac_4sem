import 'package:dartz/dartz.dart';
import 'package:todolist/src/@shared/failures/failures.dart';

typedef UsecaseResponse<T> = Future<Either<Failure, T>>;
