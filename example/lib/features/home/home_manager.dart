import 'package:flutter/material.dart';
import 'package:i_manager/extensions.dart';
import 'package:i_manager/i_manager.dart';

class HomeManager extends IManager {
  HomeManager(WidgetBuilder builder) : super(builder);

  final count = 0.rx;

  @override
  void dispose() {
    count.close();
    super.dispose();
  }
}
