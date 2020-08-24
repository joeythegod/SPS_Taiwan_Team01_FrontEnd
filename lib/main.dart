import "package:flutter/material.dart";
import "package:first_flutter_project/utils/routes.dart";
import "package:first_flutter_project/screens/login.dart";
import "package:first_flutter_project/screens/home.dart";
import "package:first_flutter_project/screens/register.dart";
import "package:first_flutter_project/screens/share.dart";
import "package:first_flutter_project/screens/friendList.dart";
import "package:first_flutter_project/screens/friendEvent.dart";
import "package:first_flutter_project/screens/eventInfo.dart";
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(myApp()));
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SPS Team 1",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        AppRoutes.login: (context) => loginPage(),
        AppRoutes.home: (context) => homePage(),
        AppRoutes.register: (context) => registerPage(),
        AppRoutes.share: (context) => sharePage(),
        AppRoutes.friendList: (context) => friendListPage(),
        AppRoutes.friendEvent: (context) => friendEventPage(),
        AppRoutes.eventInfo: (context) => eventInfoPage(),
      },
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case AppRoutes.root:
            return MaterialPageRoute(builder: (context) => loginPage());
          default:
            return MaterialPageRoute(builder: (context) => loginPage());
        }
      },
    );
  }
}

