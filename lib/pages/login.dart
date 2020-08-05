import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import '../fetch.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isHidden = true;
  final TextEditingController _controller_username = TextEditingController();
  final TextEditingController _controller_password = TextEditingController();
  String _userid;

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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48.0,
                  height: 48.0,
                  child: RaisedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      User _user;
                      _user = await login(_controller_username.text, _controller_password.text);
                      final progress = ProgressHUD.of(context);
                      progress.showWithText("Loading...");
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, "/home", arguments: _user);
                        progress.dismiss();
                      });
                    },
                  ),
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
                      final progress = ProgressHUD.of(context);
                      progress.showWithText("Loading...");
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(context, "/register");
                        progress.dismiss();
                      });
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
}