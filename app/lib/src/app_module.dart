import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/presentation/home/home_module.dart';
import 'package:todolist/src/presentation/tarefas/tarefas_module.dart';

class AppModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/home/',
          module: HomeModule(),
          transition: TransitionType.fadeIn,
        ),
        ModuleRoute(
          '/novaTarefa/',
          module: TarefasModule(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
