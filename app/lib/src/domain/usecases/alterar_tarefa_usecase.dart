import 'package:dartz/dartz.dart';
import 'package:todolist/src/@shared/errors/failures/failures.dart';
import 'package:todolist/src/@shared/interfaces/usecase.dart';
import 'package:todolist/src/domain/entities/alterar_tarefa_input.dart';
import 'package:todolist/src/domain/repositories/i_to_do_list_repository.dart';

class AlterarTarefaUsecase {
  final IToDoListRepository _toDoListRepository;

  AlterarTarefaUsecase(this._toDoListRepository);

  UsecaseResponse<bool> call(AlterarTarefaInput input) async {
    final result = await _toDoListRepository.alterarTarefa(input);

    if (result.isLeft()) return Left(Failure());

    return Right(result.toOption().toNullable()!);
  }
}
