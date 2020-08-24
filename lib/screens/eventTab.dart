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
    widget.events.sort((a, b) => a.startTime.compareTo(b.endTime));
    return Container(
      child: _event(widget.events),
    );
  }

  ListView _event(events) {
    List colorList = [
      Colors.purple.shade200,
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.red.shade200,
      Colors.yellow.shade200,
    ];
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(4.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                color: colorList[index % colorList.length],
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      events[index].startTime.substring(5, 10),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ),
              ),
              _tile(events[index], Icons.calendar_today),
            ],
          ),
        );
      },
    );
  }

  ListTile _tile(Event event, IconData icon) {
    File _image;
    final picker = ImagePicker();
    Future _getImage(picker) async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    }

    return ListTile(
        title: Text(
          event.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle:
            event.content.length == 0 ? Text("(no note)") : Text(event.content),
        leading: Text(event.startTime.substring(10, 16) +
            '\n' +
            event.endTime.substring(10, 16)),
        onTap: () =>
            Navigator.pushNamed(context, "/eventInfo", arguments: event),
        trailing: (!widget.viewOnly)
            ? Wrap(
                spacing: 1,
                children: <Widget>[
                  IconButton(
                      iconSize: 18.0,
                      icon: new Icon(Icons.photo_camera),
                      onPressed: () async {
                        await _getImage(picker);
                        if (_image != null) {
                          print('image select!');
                          String blobstoreUrl = await getBlobstoreUrl();
                          await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              content: _uploadImage(
                                  blobstoreUrl, event.eventId, _image.path),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/home",
                                          arguments: widget.user);
                                    }),
                              ],
                            ),
                          );
                        } else {
                          print('no image select!');
                        }
                      }),
                  IconButton(
                    iconSize: 18.0,
                    icon: new Icon(Icons.delete),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          content: _deleteEvent(event.userId, event.eventId),
                          actions: <Widget>[
                            FlatButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/home",
                                      arguments: widget.user);
                                }),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              )
            : null);
  }

  FutureBuilder _uploadImage(
      String blobstoreUrl, String eventId, String filePath) {
    return FutureBuilder<String>(
      future: uploadImage(blobstoreUrl, eventId, filePath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text('Upload successfully!');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  FutureBuilder _deleteEvent(String userId, String eventId) {
    return FutureBuilder<String>(
      future: deleteEvent(userId, eventId),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text('Deleted successfully!');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
