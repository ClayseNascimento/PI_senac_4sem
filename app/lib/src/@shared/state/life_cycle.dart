abstract class TDLifeCycle with TDLifeCycleBase {
  TDLifeCycle() {
    $configureLifeCycle();
  }
}

typedef ValueUpdater<T> = T Function();

class _InternalFinalCallback<T> {
  ValueUpdater<T>? _callback;

  _InternalFinalCallback({ValueUpdater<T>? callback}) : _callback = callback;

  T call() => _callback!.call();
}

mixin TDLifeCycleBase {
  final onStart = _InternalFinalCallback<void>();

  final onDelete = _InternalFinalCallback<void>();

  void onInit() {}

  void onReady() {}

  void onClose() {}

  bool _initialized = false;

  bool get initialized => _initialized;

  void _onStart() {
    if (_initialized) return;
    onInit();
    _initialized = true;
  }

  bool _isClosed = false;

  bool get isClosed => _isClosed;

  void _onDelete() {
    if (_isClosed) return;
    _isClosed = true;
    onClose();
  }

  void $configureLifeCycle() {
    _checkIfAlreadyConfigured();
    onStart._callback = _onStart;
    onDelete._callback = _onDelete;
  }

  void _checkIfAlreadyConfigured() {
    if (_initialized) {
      throw """You can only call configureLifeCycle once.
The proper place to insert it is in your class's constructor
that inherits QQLifeCycle.""";
    }
  }
}
