import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:first_flutter_project/https/api.dart';
import 'package:first_flutter_project/utils/timeListTile.dart';
import 'package:first_flutter_project/models/user.dart';

class createEventFloatingButton extends StatefulWidget {
  const createEventFloatingButton({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  _createEventFloatingButtonState createState() =>
      _createEventFloatingButtonState();
}

class _createEventFloatingButtonState extends State<createEventFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final TextEditingController _controller_title = TextEditingController();
        final TextEditingController _controller_startTime =
            TextEditingController();
        final TextEditingController _controller_endTime =
            TextEditingController();
        final TextEditingController _controller_content =
            TextEditingController();
        _controller_startTime.text =
            '${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())}';
        _controller_endTime.text =
            '${DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())}';

        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SimpleDialog(
            title: Text('Create Event'),
            children: <Widget>[
              ListTile(
                leading: Text('Title'),
                title: TextFormField(
                  controller: _controller_title,
                ),
              ),
              timeListTile(
                  title: 'Start', controller_time: _controller_startTime),
              timeListTile(title: 'End', controller_time: _controller_endTime),
              ListTile(
                leading: Text('Notes'),
                title: TextFormField(
                  controller: _controller_content,
                  maxLines: 4,
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
                      content: _createEvent(
                          widget.user.userId,
                          _controller_title.text,
                          _controller_startTime.text,
                          _controller_endTime.text,
                          _controller_content.text),
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
          ),
        );
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.green,
    );
  }

  FutureBuilder _createEvent(String userId, String title, String startTime,
      String endTime, String content) {
    return FutureBuilder<String>(
      future: createEvent(userId, title, startTime, endTime, content),
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
