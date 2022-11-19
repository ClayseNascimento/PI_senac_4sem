import 'package:todolist/src/@shared/errors/error_constants.dart';
import 'package:todolist/src/@shared/errors/exceptions/exceptions.dart';
import 'package:todolist/src/data/datasources/to_do_list_datasource.dart';
import 'package:todolist/src/data/models/alterar_tarefa_input_model.dart';
import 'package:todolist/src/data/models/criar_tarefa_input_model.dart';
import 'package:todolist/src/domain/entities/alterar_tarefa_input.dart';
import 'package:todolist/src/domain/entities/criar_tarefa_input.dart';
import 'package:todolist/src/@shared/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todolist/src/domain/entities/tarefas.dart';
import 'package:todolist/src/domain/repositories/i_to_do_list_repository.dart';

class ToDoListRepository implements IToDoListRepository {
  final IToDoListDatasource _datasource;

  ToDoListRepository(this._datasource);

  @override
  Future<Either<SaveFailure, bool>> criarTarefa(CriarTarefaInput input) async {
    try {
      final response = await _datasource.criarTarefa(CriarTarefaInputModel.fromDomain(input));
      return Right(response);
    } on RemoteException catch (exception) {
      return Left(SaveFailure(message: exception.message));
    } catch (error) {
      return Left(SaveFailure(message: msgErrConnection));
    }
  }

  @override
  Future<Either<Failure, List<Tarefas>>> getTarefa(int idUsuario) async {
    try {
      final response = await _datasource.getTarefas(idUsuario);
      final List<Tarefas> lista = response.map((e) => e.toDomain()).toList();

      return Right(lista);

    } on RemoteException catch (exception) {
      return Left(SaveFailure(message: exception.message));
    } catch (error) {
      return Left(SaveFailure(message: msgErrConnection));
    }
  }

  @override
  Future<Either<Failure, bool>> alterarTarefa(AlterarTarefaInput input) async {
    try {
      final response = await _datasource.alterarTarefa(AlterarTarefaInputModel.fromDomain(input));
      return Right(response);
    } on RemoteException catch (exception) {
      return Left(SaveFailure(message: exception.message));
    } catch (error) {
      return Left(SaveFailure(message: msgErrConnection));
    }
  }

  @override
  Future<Either<Failure, bool>> excluirItemTarefa(int idItem) async {
    try {
      final response = await _datasource.excluirItemTarefa(idItem);
      return Right(response);
    } on RemoteException catch (exception) {
      return Left(SaveFailure(message: exception.message));
    } catch (error) {
      return Left(SaveFailure(message: msgErrConnection));
    }
  }
}
