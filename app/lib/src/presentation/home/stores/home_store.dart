import 'package:todolist/src/@shared/state/stores.dart';
import 'package:todolist/src/domain/entities/tarefas.dart';
import 'package:todolist/src/domain/usecases/get_tarefas_usecase.dart';

class HomeStore extends TDStore<List<Tarefas>> {
  final GetTarefaUsecase _getTarefaUsecase;

  HomeStore(
    this._getTarefaUsecase,
  );

  setStateInitial() async {
    setLoading();
    await loadTarefas();
    setState(listTarefas);
  }

  List<Tarefas> listTarefas = [];

  loadTarefas() async {
    setLoading();
    final result = await _getTarefaUsecase.call(2);

    result.fold((failure) => failure, (tarefas) async {
      if (tarefas.isNotEmpty) {
        listTarefas = tarefas;
        return setState(listTarefas);
      }
      setEmpty([]);
    });
  }

  String getPorcentagem(int index) {
    final itens = listTarefas[index].itens;
    final itensConcluidos = [];
    for (var item in itens) {
      if (item.concluido) {
        itensConcluidos.add(item);
      }
    }

    final percentualConcluido = itensConcluidos.length / itens.length;

    return percentualConcluido.toStringAsFixed(2);
  }
}
