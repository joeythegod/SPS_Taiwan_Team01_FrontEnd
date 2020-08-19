import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/screens/eventList.dart';
import 'package:first_flutter_project/utils/createEventFloatingButton.dart';
import 'package:first_flutter_project/https/api.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User _user = ModalRoute.of(context).settings.arguments;
    dynamic eventList = _getEventData(_user);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Event List"),
              Tab(text: "Calendar"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  eventList = _getEventData(_user);
                });
              },
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            eventList,
            Text("Calendar to do"),
          ],
        ),
        floatingActionButton: createEventFloatingButton(userId: _user.userId),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child:
                    Text('Hello ${_user.username}!\n\nEmail: ${_user.email}'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text("Sign out"),
                onTap: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      content: Text("Are you sure to exit current account."),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("OK"),
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context, "/login", ModalRoute.withName('/')),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder _getEventData(User user) {
    return FutureBuilder<List<Event>>(
      future: fetchEvent(user.userId),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasData) {
          List<Event> data = snapshot.data;
          return eventListPage(data: data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}


