import 'package:flutter/widgets.dart';

typedef Disposer = void Function();

typedef TDStateUpdate = void Function();

class TDListNotifier implements Listenable {
  List<TDStateUpdate?>? _updaters = <TDStateUpdate?>[];

  @override
  Disposer addListener(TDStateUpdate listener) {
    assert(_debugAssertNotDisposed());
    _updaters!.add(listener);
    return () => _updaters!.remove(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _updaters!.remove(listener);
  }

  @mustCallSuper
  void dispose() {
    assert(_debugAssertNotDisposed());
    _updaters = null;
  }

  @protected
  void notifyChildren() {
    QQTaskManager.instance.notify(_updaters);
  }

  @protected
  void refresh() {
    assert(_debugAssertNotDisposed());
    _notifyUpdate();
  }

  void _notifyUpdate() {
    for (var element in _updaters!) {
      element!();
    }
  }

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_updaters == null) {
        throw FlutterError('''A $runtimeType was used after being disposed.\n
'Once you have called dispose() on a $runtimeType, it can no longer be used.''');
      }
      return true;
    }());
    return true;
  }

  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _updaters!.isNotEmpty;
  }

  int get listeners {
    assert(_debugAssertNotDisposed());
    return _updaters!.length;
  }
}

class QQTaskManager {
  QQTaskManager._();

  static QQTaskManager? _instance;

  static QQTaskManager get instance => _instance ??= QQTaskManager._();

  TDStateUpdate? _setter;

  List<VoidCallback>? _remove;

  void notify(List<TDStateUpdate?>? _updaters) {
    if (_setter != null) {
      if (!_updaters!.contains(_setter)) {
        _updaters.add(_setter);
        _remove!.add(() => _updaters.remove(_setter));
      }
    }
  }

  Widget exchange(
    List<VoidCallback> disposers,
    TDStateUpdate setState,
    Widget Function(BuildContext) builder,
    BuildContext context,
  ) {
    _remove = disposers;
    _setter = setState;
    final result = builder(context);
    _remove = null;
    _setter = null;
    return result;
  }
}
