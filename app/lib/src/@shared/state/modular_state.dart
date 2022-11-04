import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todolist/src/@shared/state/controllers.dart';

abstract class ModularState<TWidget extends StatefulWidget, TBind extends Object> extends State<TWidget> {
  final TBind _scope = Modular.get<TBind>();

  TBind get controller => _scope;
  TBind get store => _scope;

  @override
  void initState() {
    super.initState();

    // QQLifeCycle
    if (_scope is TDLifeCycleInterface) {
      (_scope as TDLifeCycleInterface).onInit();
      WidgetsBinding.instance.addPostFrameCallback((_) => (_scope as TDLifeCycleInterface).onReady());
    }
  }

  @override
  void dispose() {
    super.dispose();
    // QQLifeCycle
    if (_scope is TDLifeCycleInterface) {
      (_scope as TDLifeCycleInterface).onClose();
    }

    final isDisposed = Modular.dispose<TBind>();
    if (isDisposed) return;

    if (_scope is Disposable) {
      (_scope as Disposable).dispose();
    }

    if (_scope is Sink) {
      (_scope as Sink).close();
    } else if (_scope is ChangeNotifier) {
      (_scope as ChangeNotifier).dispose();
    }
  }
}
