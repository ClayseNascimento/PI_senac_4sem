import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/domain/usecases/criar_tarefa_usecase.dart';
import 'package:todolist/src/presentation/tarefas/pages/nova_tarefa_page.dart';
import 'package:todolist/src/presentation/tarefas/stores/nova_tarefa_store.dart';

class TarefasModule extends Module {
  static const String novaTarefa = "/novaTarefa";

  @override
  List<Bind<Object>> get binds => [
        // stores
        Bind.lazySingleton((i) => NovaTarefaStore(
              i<CriarTarefaUsecase>(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          // Modular.initialRoute,
          '/',
          child: (_, __) => const NovaTarefaPage(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
