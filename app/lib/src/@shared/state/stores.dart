import 'package:todolist/src/@shared/state/state_mixin.dart';
import 'package:todolist/src/@shared/state/controllers.dart';

abstract class TDStore<T> extends TDStoreInterface with TDStateMixin<T> {
  setError(String error) => change(null, status: RxStatus.error(error));

  setEmpty(T state) => change(state, status: RxStatus.empty());

  setLoading() => change(null, status: RxStatus.loading());

  setState(T state) => change(state, status: RxStatus.success());
}
