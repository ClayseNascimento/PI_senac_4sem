import 'package:todolist/src/@shared/state/stores.dart';

class HomeStore extends TDStore<List<Map<String, Object>>> {
  setStateInitial() {
    setLoading();
    setState(listTarefas);
    // setEmpty(listTarefas);
  }

  final listTarefas = [
    {
      'titulo': 'tarefa1',
      'itens': [
        {'item1', 'ok'},
        {'item2', 'ok'},
        {'item3', 'pen'},
        {'item4', 'pen'}
      ]
    },
    {
      'titulo': 'tarefa2',
      'itens': [
        {'item1', 'ok'},
        {'item2', 'ok'},
        {'item3', 'pen'}
      ]
    },
    {
      'titulo': 'tarefa3',
      'itens': [
        {'item1', 'ok'},
        {'item2', 'ok'},
        {'item3', 'pen'}
      ]
    },
  ];

  setState(listTarefas);
}
