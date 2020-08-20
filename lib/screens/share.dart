import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/screens/drawer.dart';

class sharePage extends StatefulWidget {
  @override
  _sharePageState createState() => _sharePageState();
}

class _sharePageState extends State<sharePage> {
  final TextEditingController _controller_friendUsername = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User _user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text("Share to friend"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller_friendUsername,
                decoration: InputDecoration(hintText: "Enter your friend's username"),
              ),
            ),
            RaisedButton(
              child: Text('Confirm'),
              onPressed: () async {
                await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    content: _shareToFriend(_user.userId, _controller_friendUsername.text),
                    actions: <Widget>[
                      FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                              Navigator.pop(context);
                              _controller_friendUsername.text = "";
                          }
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      drawer: drawerPage(user: _user),
    );
  }

  // to do
  FutureBuilder _shareToFriend(String userId, String friendUsername) {
    final myFuture = Future(() {
      return "joey";
    });
    return FutureBuilder<String>(
//      future: shareToFriend(userId, friendUsername),
      future: myFuture,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Text('Share to ${friendUsername} successfully!');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
