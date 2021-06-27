import 'package:example/features/login/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:i_manager/extensions.dart';

import 'home/home_manager.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'When trying to get HomeManage an exception will be thrown'
                ' because HomeManager widget is wraped at the top of home page,'
                ' while dummy page is not in the widget tree of home page,',
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                child: Text('get HomeManager instance'),
                onPressed: () {
                  /// Because [HomeManager] is in another route we can access it here
                  /// so an exception of type [ManagerNotFoundException] will be thrown
                  final homeManager = context.getManager<HomeManager>();
                },
              ),
              SizedBox(height: 30),
              Text(
                'We will be able to get instance of LoginManager'
                ' because DummyPage is in the subtree of LoginManager widget'
                '(LoginManager is above MaterialApp)',
                textAlign: TextAlign.center,
              ),
              RaisedButton(
                child: Text('get Login instance'),
                onPressed: () {
                  /// Because [LoginManager] above [MaterialApp] we can access the intance from anywhere in the tree
                  final loginManager = context.getManager<LoginManager>();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
