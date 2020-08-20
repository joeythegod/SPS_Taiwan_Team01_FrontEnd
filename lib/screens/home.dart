import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/screens/eventTab.dart';
import 'package:first_flutter_project/screens/drawer.dart';
import 'package:first_flutter_project/utils/createEventFloatingButton.dart';
import 'package:first_flutter_project/https/api.dart';


class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    User _user = ModalRoute.of(context).settings.arguments;
    dynamic eventTab = _fetchEvent(_user);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "My Events"),
              Tab(text: "Calendar View"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  eventTab = _fetchEvent(_user);
                });
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            eventTab,
            Text("Calendar to do"),
          ],
        ),
        floatingActionButton: createEventFloatingButton(user: _user),
        drawer: drawerPage(user: _user),
      ),
    );
  }

  FutureBuilder _fetchEvent(User user) {
    return FutureBuilder<List<Event>>(
      future: fetchEvent(user.userId),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasData) {
          List<Event> events = snapshot.data;
          return eventTab(events: events, user: user, viewOnly: false,);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}


