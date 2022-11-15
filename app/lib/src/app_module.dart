import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/@shared/interceptors/dio_http_client.dart';
import 'package:todolist/src/data/data_core_module.dart';
import 'package:todolist/src/domain/domain_core_module.dart';
import 'package:todolist/src/presentation/home/home_module.dart';
import 'package:todolist/src/presentation/tarefas/tarefas_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // clients
        Bind.singleton((i) => DioHttpClient()),
        // core_modules
        ...DataCoreModule.binds,
        ...DomainCoreModule.binds,
      ];

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
