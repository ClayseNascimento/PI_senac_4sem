import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:responsive_framework/responsive_framework.dart';


class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ResponsiveWrapper.builder(
            child,
            maxWidth: 8000,
            minWidth: 250,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(250, name: MOBILE),
              const ResponsiveBreakpoint.resize(700, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
          );
        });
  }
}
