import 'package:todolist/src/@shared/state/life_cycle.dart';
import 'package:todolist/src/@shared/state/list_notifier.dart';

abstract class TDControllerInterface extends TDLifeCycleInterface with TDListNotifier {}
abstract class TDStoreInterface extends TDLifeCycleInterface with TDListNotifier {}

abstract class TDLifeCycleInterface extends TDLifeCycle {
  @override
  void onInit() {}

  @override
  void onReady() {}

  @override
  void onClose() {}
}
