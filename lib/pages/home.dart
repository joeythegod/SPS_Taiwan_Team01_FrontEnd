import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'event.dart';
import '../fetch.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User _user = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Event"),
              Tab(text: "Calendar"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            EventPage(),
            Text("Calendar to do"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            DateTime startTime;
            DateTime endTime;
            startTime = await DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime(2018, 1, 1, 0, 0),
                maxTime: DateTime(2025, 12, 31, 23, 59),
                onChanged: (date) {
                  print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                },
                onConfirm: (date) {
                  print('confirm $date');
                },
                currentTime: DateTime.now(),
                locale: LocaleType.zh);
            endTime = await DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime(2018, 1, 1, 0, 0),
                maxTime: DateTime(2025, 12, 31, 23, 59),
                onChanged: (date) {
                  print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                },
                onConfirm: (date) {
                  print('confirm $date');
                },
                currentTime: DateTime.now(),
                locale: LocaleType.zh);
            
            print(startTime);
            print(endTime);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
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
}