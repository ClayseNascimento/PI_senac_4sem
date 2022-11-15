import 'package:dartz/dartz.dart';
import 'package:todolist/src/@shared/errors/failures/failures.dart';
import 'package:todolist/src/@shared/interfaces/usecase.dart';
import 'package:todolist/src/domain/entities/criar_tarefa_input.dart';
import 'package:todolist/src/domain/repositories/i_to_do_list_repository.dart';

class CriarTarefaUsecase {
  final IToDoListRepository _toDoListRepository;

  CriarTarefaUsecase(this._toDoListRepository);

  UsecaseResponse<bool> call(CriarTarefaInput input) async {
    final result = await _toDoListRepository.criarTarefa(input);

    if (result.isLeft()) return Left(Failure());

    return Right(result.toOption().toNullable()!);
  }
}

