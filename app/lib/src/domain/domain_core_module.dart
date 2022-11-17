import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/domain/repositories/i_to_do_list_repository.dart';
import 'package:todolist/src/domain/usecases/alterar_tarefa_usecase.dart';
import 'package:todolist/src/domain/usecases/criar_tarefa_usecase.dart';
import 'package:todolist/src/domain/usecases/get_tarefas_usecase.dart';

class DomainCoreModule {
  static List<Bind> get binds => [
    // usecases
    Bind.lazySingleton((i) => CriarTarefaUsecase(i<IToDoListRepository>())),
    Bind.lazySingleton((i) => GetTarefaUsecase(i<IToDoListRepository>())),
    Bind.lazySingleton((i) => AlterarTarefaUsecase(i<IToDoListRepository>())),
  ];
}
