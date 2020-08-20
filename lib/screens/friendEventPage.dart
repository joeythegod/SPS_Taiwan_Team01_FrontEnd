import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/models/friend.dart';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/screens/eventTab.dart';
import 'package:first_flutter_project/https/api.dart';


class friendEventPage extends StatefulWidget {
  @override
  _friendEventPageState createState() => _friendEventPageState();
}

class _friendEventPageState extends State<friendEventPage> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    User _user = arguments["user"];
    Friend _friend = arguments["friend"];
    dynamic eventTab = _fetchEvent(_friend, _user);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Friend Events"),
              Tab(text: "Calendar View"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  eventTab = _fetchEvent(_friend, _user);
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
      ),
    );
  }

  FutureBuilder _fetchEvent(Friend friend, User user) {
    return FutureBuilder<List<Event>>(
      future: fetchEvent(friend.userId),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasData) {
          List<Event> events = snapshot.data;
          return eventTab(events: events, user: user, viewOnly: true,);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}


