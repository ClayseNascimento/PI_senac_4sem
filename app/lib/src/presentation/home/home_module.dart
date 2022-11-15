import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/domain/usecases/get_tarefas_usecase.dart';
import 'package:todolist/src/presentation/home/pages/home_page.dart';
import 'package:todolist/src/presentation/home/stores/home_store.dart';

class HomeModule extends Module {
  static const String home = "/home";

  @override
  List<Bind<Object>> get binds => [
        // stores
        Bind.lazySingleton((i) => HomeStore(
           i<GetTarefaUsecase>(),
        )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          // Modular.initialRoute,
          child: (_, __) => const HomePage(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
