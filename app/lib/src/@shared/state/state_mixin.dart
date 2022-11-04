import 'package:flutter/material.dart';
import 'package:todolist/src/@shared/state/list_notifier.dart';
import 'package:todolist/src/@shared/state/simple_builder.dart';

mixin TDStateMixin<T> on TDListNotifier {
  T? _value;
  RxStatus? _status;

  RxStatus get status {
    notifyChildren();
    return _status ??= _status = RxStatus.loading();
  }

  T? get state => value;

  @protected
  T? get value {
    notifyChildren();
    return _value;
  }

  @protected
  set value(T? newValue) {
    if (_value == newValue) return;
    _value = newValue;
    refresh();
  }

  @protected
  void change(T? newState, {RxStatus? status}) {
    var _canUpdate = false;
    if (status != null) {
      _status = status;
      _canUpdate = true;
    }
    if (newState != _value) {
      _value = newState;
      _canUpdate = true;
    }
    if (_canUpdate) {
      refresh();
    }
  }

  void append(Future<T> Function() body(), {String? errorMessage}) {
    final compute = body();
    compute().then((newValue) {
      change(newValue, status: RxStatus.success());
    }, onError: (err) {
      change(state, status: RxStatus.error(errorMessage ?? err.toString()));
    });
  }
}

extension StateExt<T> on TDStateMixin<T> {
  Widget obx(
    NotifierBuilder<T?> widget, {
    Widget Function(String? error)? onError,
    Widget? onLoading,
    Widget? onEmpty,
  }) {
    return TDSimpleBuilder(builder: (_) {
      if (status.isLoading) {
        return onLoading ?? const SizedBox.shrink();
      } else if (status.isError) {
        return onError != null ? onError(status.errorMessage) : const SizedBox.shrink();
      } else if (status.isEmpty) {
        return onEmpty ?? const SizedBox.shrink();
      }
      return widget(value);
    });
  }
}

class RxStatus {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final bool isEmpty;
  final bool isLoadingMore;
  final String? errorMessage;

  RxStatus._({
    this.isEmpty = false,
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.errorMessage,
    this.isLoadingMore = false,
  });

  factory RxStatus.loading() {
    return RxStatus._(isLoading: true);
  }

  factory RxStatus.loadingMore() {
    return RxStatus._(isSuccess: true, isLoadingMore: true);
  }

  factory RxStatus.success() {
    return RxStatus._(isSuccess: true);
  }

  factory RxStatus.error([String? message]) {
    return RxStatus._(isError: true, errorMessage: message);
  }

  factory RxStatus.empty() {
    return RxStatus._(isEmpty: true);
  }
}

typedef NotifierBuilder<T> = Widget Function(T state);
