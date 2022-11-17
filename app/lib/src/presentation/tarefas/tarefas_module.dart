import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/domain/usecases/alterar_tarefa_usecase.dart';
import 'package:todolist/src/domain/usecases/criar_tarefa_usecase.dart';
import 'package:todolist/src/presentation/tarefas/pages/editar_tarefa_page.dart';
import 'package:todolist/src/presentation/tarefas/pages/nova_tarefa_page.dart';
import 'package:todolist/src/presentation/tarefas/stores/editar_tarefa_store.dart';
import 'package:todolist/src/presentation/tarefas/stores/nova_tarefa_store.dart';

class TarefasModule extends Module {
  static const String novaTarefa = "/novaTarefa";
  static const String editarTarefa = "/editarTarefa";

  @override
  List<Bind<Object>> get binds => [
        // stores
        Bind.lazySingleton((i) => NovaTarefaStore(
              i<CriarTarefaUsecase>(),
            )),

        Bind.lazySingleton((i) => EditarTarefaStore(
              i<AlterarTarefaUsecase>(),
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
        ChildRoute(
          '/editarTarefa',
          child: (context, args) => EditarTarefaPage(tarefa: args.data?[EditarTarefaPage.editarTarefaArgs]),
          transition: TransitionType.fadeIn,
        )
      ];
}
