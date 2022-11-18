import 'package:dartz/dartz.dart';
import 'package:todolist/src/@shared/errors/failures/failures.dart';
import 'package:todolist/src/domain/entities/alterar_tarefa_input.dart';
import 'package:todolist/src/domain/entities/criar_tarefa_input.dart';
import 'package:todolist/src/domain/entities/tarefas.dart';

abstract class IToDoListRepository {
  Future<Either<Failure, bool>> criarTarefa(CriarTarefaInput input);
  Future<Either<Failure, List<Tarefas>>> getTarefa(int idUsuario);
  Future<Either<Failure, bool>> alterarTarefa(AlterarTarefaInput input);
  Future<Either<Failure, bool>> excluirItemTarefa(int idItem);
}