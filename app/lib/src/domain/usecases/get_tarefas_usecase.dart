import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:todolist/src/@shared/errors/failures/failures.dart';
import 'package:todolist/src/@shared/interfaces/usecase.dart';
import 'package:todolist/src/domain/entities/tarefas.dart';
import 'package:todolist/src/domain/repositories/i_to_do_list_repository.dart';

class GetTarefaUsecase {
  final IToDoListRepository _toDoListRepository;

  GetTarefaUsecase(this._toDoListRepository);

  UsecaseResponse<List<Tarefas>> call(int idUsuario) async {
    log('usecase');
    final result = await _toDoListRepository.getTarefa(idUsuario);


    if (result.isLeft()) return Left(GetListFailure(message: 'erro no get'));
    final tarefas = result.toOption().toNullable()!;

    if (tarefas.isEmpty) return Left(EmptyListFailure());
    return Right(tarefas);
  }
}
