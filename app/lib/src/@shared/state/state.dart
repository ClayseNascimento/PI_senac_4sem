
import 'package:flutter/material.dart';

mixin TDStateUpdaterMixin<T extends StatefulWidget> on State<T> {
  qqUpdate() {
    if (mounted) setState(() {});
  }

}
