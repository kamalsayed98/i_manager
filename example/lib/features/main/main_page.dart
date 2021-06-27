import 'package:example/features/home/home_page.dart';
import 'package:example/features/login/login_manager.dart';
import 'package:example/features/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:i_manager/extensions.dart';
import 'package:i_manager/widgets/i_manager_builder.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// first we will get instance of [LoginManager] that we passed above [MaterialApp] at the top of the tree
    final loginManager = context.getManager<LoginManager>();
    return IManagerBuilder<bool>(
      /// pass isLoggedIn subject to know if user logged in or not
      /// then display widget based on that
      /// NOTE: when value of the subject got changed
      /// builder method will run again
      /// and return another value based of snapshot data at that moment
      subject: loginManager.isLoggedIn,
      builder: (context, snapshot) {
        if (snapshot.data) {
          return MyHomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
