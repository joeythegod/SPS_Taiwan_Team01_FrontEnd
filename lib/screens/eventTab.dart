import 'package:flutter/material.dart';
import 'dart:io';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/models/friend.dart';
import 'package:first_flutter_project/https/api.dart';
import 'package:image_picker/image_picker.dart';

class eventTab extends StatefulWidget {
  const eventTab({
    Key key,
    @required this.events,
    @required this.user,
    @required this.viewOnly,
    this.friend,
  }) : super(key: key);
  final List<Event> events;
  final User user;
  final bool viewOnly;
  final Friend friend;
  @override
  _eventTabState createState() => _eventTabState();
}

class _eventTabState extends State<eventTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _event(widget.events),
    );
  }

  ListView _event(events) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Card(
          child: _tile(events[index], Icons.calendar_today)
        );
      }
    );
  }

  ListTile _tile(Event event, IconData icon) {
    File _image;
    final picker = ImagePicker();
    Future _getImage(picker) async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      setState(() {
        _image = File(pickedFile.path);
        print(pickedFile.path);
      });
    }

    return ListTile(
      title: Text(event.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(event.startTime + ' ~ ' + event.endTime),
      leading: Icon(
        icon,
        color: Colors.red[500],
      ),
      onTap: () {
//        print('tap');
      },
      trailing: (!widget.viewOnly) ? Wrap(
        spacing: 6,
        children: <Widget>[
          IconButton(
            icon: new Icon(Icons.photo_camera),
            onPressed: () {
              _getImage(picker);
            },
          ),
          IconButton(
            icon: new Icon(Icons.delete),
            onPressed: ()  async {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  content: _deleteEvent(event.userId, event.eventId),
                  actions: <Widget>[
                    FlatButton(
                        child: Text("OK"),
                        onPressed: () {
//                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/home", arguments: widget.user);
                        }
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ) : null
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