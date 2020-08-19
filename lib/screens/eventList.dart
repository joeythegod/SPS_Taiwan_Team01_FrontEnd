import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/https/api.dart';

class eventListPage extends StatefulWidget {
  const eventListPage({
    Key key,
    @required this.data,
  }) : super(key: key);
  final List<Event> data;
  @override
  _eventListPageState createState() => _eventListPageState();
}

class _eventListPageState extends State<eventListPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _event(widget.data),
      onRefresh: () async {
      },
    );
  }

  ListView _event(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: _tile(data[index], Icons.calendar_today)
        );
      }
    );
  }

  ListTile _tile(Event data, IconData icon) {
    return ListTile(
      title: Text(data.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(data.startTime + ' ~ ' + data.endTime),
      leading: Icon(
        icon,
        color: Colors.red[500],
      ),
      onTap: () {
//        print('tap');
      },
      trailing: Wrap(
        spacing: 6,
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.photo_camera),
            onPressed: () { /* Your code */ },
          ),
          IconButton(
            icon: new Icon(Icons.delete),
            onPressed: ()  async {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  content: _deleteEvent(data.userId, data.eventId),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
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
  }

  FutureBuilder _deleteEvent(String userId, String eventId) {
    return FutureBuilder<String>(
      future: deleteEvent(userId, eventId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text('Deleted successfully!');;
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}