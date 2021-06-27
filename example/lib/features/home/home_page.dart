import 'package:example/features/login/login_manager.dart';
import 'package:flutter/material.dart';
import 'package:i_manager/extensions.dart';
import 'package:i_manager/widgets/i_manager_builder.dart';
import 'package:i_navigation/extension.dart';

import '../dummy_page.dart';
import 'home_manager.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    /// By wrapping [HomeManager] in here we will be abl to access the same instance from any widget in the same page
    /// NOTE: if we pushed a new route we will not be able to access this instance from there
    return HomeManager(
      (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('IManager Demo Home Page'),
          ),
          body: HomeMainWidget(),
        );
      },
    );
  }
}

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text('HomeMainWidget'),
              SizedBox(
                height: 8,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// List of widgets in the page
                      /// each one is separate widget
                      /// in separate class
                      /// but [HomeManager] can be accessed from any one of them
                      IncrementWidget(),
                      SizedBox(height: 10),
                      CountWidget(),
                      SizedBox(height: 10),
                      DecrementWidget(),
                      SizedBox(height: 10),
                      DummyPageWidget(),
                      SizedBox(height: 10),
                      RaisedButton(
                        child: Text('logout'),
                        onPressed: () {
                          final loginManager =
                              context.getManager<LoginManager>();
                          loginManager.isLoggedIn.setValue(false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncrementWidget extends StatelessWidget {
  const IncrementWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('IncrementWidget'),
        SizedBox(
          height: 8,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              heroTag: 1,
              onPressed: () {
                final homeManager = context.getManager<HomeManager>();
                homeManager.count.setValue(homeManager.count.value + 1);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

class DecrementWidget extends StatelessWidget {
  const DecrementWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('DecrementWidget'),
        SizedBox(
          height: 8,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FloatingActionButton(
              heroTag: 2,
              onPressed: () {
                final homeManager = context.getManager<HomeManager>();
                homeManager.count.setValue(homeManager.count.value - 1);
              },
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeManager = context.getManager<HomeManager>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('CountWidget'),
        SizedBox(
          height: 8,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: IManagerBuilder<int>(
                subject: homeManager.count,
                builder: (context, snapshot) {
                  return Text(snapshot.data.toString());
                }),
          ),
        ),
      ],
    );
  }
}

class DummyPageWidget extends StatelessWidget {
  const DummyPageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('DummyPageWidget'),
        SizedBox(
          height: 8,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.red),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              child: Text('To dummy page'),
              onPressed: () {
                /// Using [INavigation] package we can push route easily by writing this simple line
                context.pushRoute(DummyPage());
              },
            ),
          ),
        ),
      ],
    );
  }
}
