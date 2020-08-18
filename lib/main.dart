import "package:flutter/material.dart";
import "package:first_flutter_project/utils/routes.dart";
import "package:first_flutter_project/screens/login.dart";
import "package:first_flutter_project/screens/home.dart";
import "package:first_flutter_project/screens/register.dart";


void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SPS Team 1",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppRoutes.login: (context) => LoginPage(),
        AppRoutes.home: (context) => HomePage(),
        AppRoutes.register: (context) => RegisterPage(),

      },
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case AppRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}

