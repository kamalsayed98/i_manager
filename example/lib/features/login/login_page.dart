import 'package:example/features/login/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:i_manager/extensions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IManager Demo Login Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: () {
            /// on press we will get intance of [LoginManager]
            /// and setValue for isLoggedIn to true
            final loginManager = context.getManager<LoginManager>();
            loginManager.isLoggedIn.setValue(true);
          },
        ),
      ),
    );
  }
}
