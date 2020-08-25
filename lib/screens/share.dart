import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/screens/drawer.dart';
import 'package:first_flutter_project/https/api.dart';

class sharePage extends StatefulWidget {
  @override
  _sharePageState createState() => _sharePageState();
}

class _sharePageState extends State<sharePage> {
  final TextEditingController _controller_friendUsername =
      TextEditingController();

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: 64.0,
              padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
              child: TextFormField(
                controller: _controller_friendUsername,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Enter your friend's username *",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100.0,
              height: 48.0,
              child: FlatButton(
                child: Text(
                  'Confirm',
                ),
                color: Colors.white.withOpacity(0.05),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
                      content: _addFriend(
                          _user.userId, _controller_friendUsername.text),
                      actions: <Widget>[
                        FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                              _controller_friendUsername.text = "";
                            }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: drawerPage(user: _user),
    );
  }

  // to do
  FutureBuilder _addFriend(String userId, String friendUsername) {
    return FutureBuilder<String>(
      future: addFriend(userId, friendUsername),
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
