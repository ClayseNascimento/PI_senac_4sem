import 'package:flutter/widgets.dart';
import 'package:todolist/src/@shared/state/list_notifier.dart';
import 'package:todolist/src/@shared/state/state.dart';

class TDSimpleBuilder extends StatefulWidget {
  final Widget Function(BuildContext) builder;

  const TDSimpleBuilder({Key? key, required this.builder}) : super(key: key);

  @override
  _TDSimpleBuilderState createState() => _TDSimpleBuilderState();
}

class _TDSimpleBuilderState extends State<TDSimpleBuilder> with TDStateUpdaterMixin{
  final disposers = <Disposer>[];

  @override
  void dispose() {
    super.dispose();
    for (final disposer in disposers) {
      disposer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return QQTaskManager.instance.exchange(
      disposers,
      qqUpdate,
      widget.builder,
      context,
    );
  }
}
