import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../fetch.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controller_username = TextEditingController();
  final TextEditingController _controller_password = TextEditingController();
  final TextEditingController _controller_email = TextEditingController();
  Future<User> _futureUser;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      backgroundColor: Colors.black87,
      child: Builder(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacementNamed(context, "/login");
//            Navigator.pop(context);
//            return Future.value(false);
          },
          child:Scaffold(
            appBar: AppBar(
              title: Text("Register"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller_username,
                      decoration: InputDecoration(hintText: 'Enter username'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller_password,
                      decoration: InputDecoration(hintText: 'Enter password'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _controller_email,
                      decoration: InputDecoration(hintText: 'Enter email'),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Confirm'),
                    onPressed: () {
  //                    setState(() {
  //                      _futureUser = createUser(_controller_username.text, _controller_password.text, _controller_email.text);
  //                    });
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
//
//  FutureBuilder _createUser() {
//    return FutureBuilder<User>(
//      future: _createUser(_controller_username.text, _controller_password.text, _controller_email.text),
//      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
//        if (snapshot.hasData) {
//          List<Event> data = snapshot.data;
//          return _event(data);
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//        return CircularProgressIndicator();
//      },
//    );
//  }
}