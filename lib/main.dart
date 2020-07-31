import "package:flutter/material.dart";
import "pages/login.dart";
import "pages/home.dart";
import "pages/routes.dart";


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
        AppRoutes.home: (context) => MainPage(),
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