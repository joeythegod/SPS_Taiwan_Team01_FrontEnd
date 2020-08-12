import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../fetch.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isHidden = true;
  bool _loginSucceed = false;
  User _data;
  final TextEditingController _controller_username = TextEditingController();
  final TextEditingController _controller_password = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      backgroundColor: Colors.black87,
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Login"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: TextFormField(
                    controller: _controller_username,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Name *",
                      hintText: "Your username",
                    ),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: TextFormField(
                    obscureText: _isHidden,
                    controller: _controller_password,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: _toggleVisibility,
                        icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
                      ),
                      labelText: "Password *",
                      hintText: "Your password",
                    ),
                  ),
                ),
                SizedBox(
                  height: 52.0,
                ),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        content: _login(),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              if (_loginSucceed) {
                                Navigator.pushNamedAndRemoveUntil(context, "/home",  ModalRoute.withName('/'), arguments: _data);
                              }
                              else {
                                Navigator.pop(context);
                              }
                            }
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 52.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48.0,
                  height: 48.0,
                  child: RaisedButton(
                    child: Text("Register Now!"),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/register");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder _login() {
    return FutureBuilder<User>(
      future: login(_controller_username.text, _controller_password.text),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          _data = snapshot.data;
          _loginSucceed = true;
          return Text('You login as ${_data.username}');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}