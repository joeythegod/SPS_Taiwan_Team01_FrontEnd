import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';

class drawerPage extends StatefulWidget {
  const drawerPage({
    Key key,
    @required this.user,
  }) : super(key: key);
  final User user;
  @override
  _drawerPageState createState() => _drawerPageState();
}

class _drawerPageState extends State<drawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child:
            Text('Hello ${widget.user.username}!\n\nEmail: ${widget.user.email}'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("My events"),
            onTap: () => Navigator.pushNamed(context, "/home", arguments: widget.user),
          ),
          ListTile(
            title: Text("Share to friend"),
            onTap: () => Navigator.pushNamed(context, "/share", arguments: widget.user),
          ),
          ListTile(
            title: Text("View my friend's events"),
            onTap: () => Navigator.pushNamed(context, "/friendList", arguments: widget.user),
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
    );
  }
}