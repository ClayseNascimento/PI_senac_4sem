import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/presentation/home/pages/home_page.dart';

class HomeModule extends Module {
  static const String home = "/home";

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
