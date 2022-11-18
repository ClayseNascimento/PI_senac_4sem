import 'package:dartz/dartz.dart';
import 'package:todolist/src/@shared/errors/failures/failures.dart';
import 'package:todolist/src/@shared/interfaces/usecase.dart';
import 'package:todolist/src/domain/repositories/i_to_do_list_repository.dart';

class ExcluirItemTarefaUsecase {
  final IToDoListRepository _toDoListRepository;

  ExcluirItemTarefaUsecase(this._toDoListRepository);

  UsecaseResponse<bool> call(int idItem) async {
    final result = await _toDoListRepository.excluirItemTarefa(idItem);

    if (result.isLeft()) return Left(Failure());

    return Right(result.toOption().toNullable()!);
  }
}
