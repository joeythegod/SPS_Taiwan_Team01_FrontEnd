import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'event.dart';
import '../fetch.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            EventPage(userId: _user.userId),
            Text("Calendar to do"),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final TextEditingController _controller_title = TextEditingController();
            final TextEditingController _controller_startTime = TextEditingController();
            final TextEditingController _controller_endTime = TextEditingController();
            final TextEditingController _controller_content = TextEditingController();
            _controller_startTime.text = '${DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now())}';
            _controller_endTime.text = '${DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now())}';

            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => SimpleDialog(
                title: Text('Create Event'),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.text_fields),
                    title: TextFormField(
                      controller: _controller_title,
                      decoration: const InputDecoration(
                        labelText: "Title *",
                        hintText: "Your title",
                      ),
                    ),
                  ),
                  timeListTile(title: 'startTime', controller_time: _controller_startTime),
                  timeListTile(title: 'endTime', controller_time: _controller_endTime),
                  ListTile(
                    leading: Icon(Icons.text_format),
                    title: TextFormField(
                        controller: _controller_content,
                        decoration: const InputDecoration(
                          labelText: "Content *",
                          hintText: "Your content",
                        ),
                        maxLines: 1,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.cancel),
                    title: Text('Cancelled'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.send),
                    title: Text('Create!'),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          content: _createEvent(_user.userId, _controller_title.text, _controller_startTime.text, _controller_endTime.text, _controller_content.text),
                          actions: <Widget>[
                            FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
//                                  Navigator.pushNamedAndRemoveUntil(context, "/home",  ModalRoute.withName('/'));
                                }
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
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

  FutureBuilder _createEvent(String userId, String title, String startTime, String endTime, String content) {
    return FutureBuilder<String>(
      future: createEvent(userId, title, startTime,
          endTime, content),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text('Created successfully!');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class timeListTile extends StatefulWidget {
  const timeListTile({
    Key key,
    @required this.title,
    @required this.controller_time,
  }) : super(key: key);

  final String title;
  final TextEditingController controller_time;
  @override
  _timeListTileState createState() => _timeListTileState();
}

class _timeListTileState extends State<timeListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.timer),
      title: Text('${widget.title}'),
      subtitle: Text('${widget.controller_time.text}'),
      onTap: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2018, 1, 1, 0, 0),
          maxTime: DateTime(2025, 12, 31, 23, 59),
          onChanged: (date) {
            print('change $date in time zone ');
          },
          onConfirm: (date) {
            print('confirm $date');
            setState(() {
              widget.controller_time.text =
                  '${DateFormat('yyyy-MM-dd kk:mm:ss').format(date)}';
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.zh,
        );
      },
    );
  }
}
