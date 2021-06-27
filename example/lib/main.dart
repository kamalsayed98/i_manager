import 'package:flutter/material.dart';
import 'package:i_manager/i_manager.dart';
import 'package:i_navigation/i_navigation.dart';

import 'features/login/login_manager.dart';
import 'features/main/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return INavigation(
      /// INavigation is a package that helps in navigation,
      /// for more information check [https://pub.dev/packages/i_navigation]
      child: MultiIManagerProvider(
        /// Because we have only one IManager instance we want to wrap it here we can wrap it directly
        /// but because for big projects usually we will have more than one manager above [MaterialApp]
        /// it is a good practice to use [MultiIManagerProvider]
        iManagersBuilder: [
          (child) => LoginManager((cxt) => child),
        ],
        child: MaterialApp(
          title: 'IManager Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MainPage(),
        ),
      ),
    );
  }
}
