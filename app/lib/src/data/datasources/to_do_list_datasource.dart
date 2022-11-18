import 'package:todolist/src/@shared/errors/error_constants.dart';
import 'package:todolist/src/@shared/errors/exceptions/exceptions.dart';
import 'package:todolist/src/@shared/interceptors/http_client.dart';
import 'package:todolist/src/data/models/alterar_tarefa_input_model.dart';
import 'package:todolist/src/data/models/criar_tarefa_input_model.dart';
import 'package:todolist/src/data/models/tarefas_model.dart';

abstract class IToDoListDatasource {
  Future<bool> criarTarefa(CriarTarefaInputModel input);
  Future<List<TarefasModel>> getTarefas(int idUsuario);
  Future<bool> alterarTarefa(AlterarTarefaInputModel input);
  Future<bool> excluirItemTarefa(int idItem);
}

class ToDoListDatasource implements IToDoListDatasource {
  final IHttpClient _httpClient;

  ToDoListDatasource(this._httpClient);

  @override
  Future<bool> criarTarefa(CriarTarefaInputModel input) async {
    try {
      final response = await _httpClient.post('/criarTarefa', data: input.toJson());
      if (response.statusCode == 201 && response.data != null && response.data['sucesso']) {
        return true;
      } else {
        throw RemoteException(message: response.data);
      }
    } on RemoteException catch (exception) {
      throw RemoteException(message: exception.message);
    } catch (error) {
      throw RemoteException(message: msgErrConnection);
    }
  }

  @override
  Future<List<TarefasModel>> getTarefas(int idUsuario) async {
    try {
      final response = await _httpClient.get('/tarefas/$idUsuario');
      if (response.statusCode == 200 && response.data != null) {
        final data = (response.data);
        if (data.isEmpty) return [];
        final List<TarefasModel> lista = [];

        for (var item in data) {
          lista.add(TarefasModel.fromJson(item));
        }
        return lista;
      } else {
        throw RemoteException(message: response.data);
      }
    } on RemoteException catch (exception) {
      throw RemoteException(message: exception.message);
    } catch (error) {
      throw RemoteException(message: msgErrConnection);
    }
  }

  @override
  Future<bool> alterarTarefa(AlterarTarefaInputModel input) async {
     try {
      final response = await _httpClient.post('/alterarTarefa', data: input.toJson());
      if (response.statusCode == 201 && response.data != null && response.data['sucesso']) {
        return true;
      } else {
        throw RemoteException(message: response.data);
      }
    } on RemoteException catch (exception) {
      throw RemoteException(message: exception.message);
    } catch (error) {
      throw RemoteException(message: msgErrConnection);
    }
  }

  @override
  Future<bool> excluirItemTarefa(int idItem) async{
       try {
      final response = await _httpClient.delete('/itemTarefa/$idItem');
      if (response.statusCode == 200 && response.data != null && response.data['sucesso']) {
        return true;
      } else {
        throw RemoteException(message: response.data);
      }
    } on RemoteException catch (exception) {
      throw RemoteException(message: exception.message);
    } catch (error) {
      throw RemoteException(message: msgErrConnection);
    }
  }
}
