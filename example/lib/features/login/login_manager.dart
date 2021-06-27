import 'package:flutter/material.dart';
import 'package:i_manager/extensions.dart';
import 'package:i_manager/i_manager.dart';

class LoginManager extends IManager {
  LoginManager(WidgetBuilder builder) : super(builder);

  final isLoggedIn = false.rx;

  @override
  void dispose() {
    isLoggedIn.close();
    super.dispose();
  }
}
