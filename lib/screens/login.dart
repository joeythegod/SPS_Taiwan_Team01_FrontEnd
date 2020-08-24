import 'package:flutter/material.dart';
import 'package:first_flutter_project/https/api.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/gestures.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _isHidden = true;
  bool _loginSucceed = false;
  User _user;
  final TextEditingController _controller_username = TextEditingController();
  final TextEditingController _controller_password = TextEditingController();
  TextStyle buttonStyle = TextStyle(color: Colors.black54, fontSize: 18);
  TextStyle linkStyle = TextStyle(color: Colors.grey, decoration: TextDecoration.underline, fontSize: 30);

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Login"),
//      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 104.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                NetworkImage('https://blog.hubspot.com/hubfs/image8-2.jpg#50x50'),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            Container(
              height: 64.0,
              padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
              child: TextFormField(
                controller: _controller_username,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Username *",
                  hintText: "Your username",
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
            Container(
              height: 64.0,
              padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
              child: TextFormField(
                obscureText: _isHidden,
                controller: _controller_password,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: _toggleVisibility,
                      icon: _isHidden
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  labelText: "Password *",
                  hintText: "Your password",
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
              height: 52.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100.0,
              height: 48.0,
              child: FlatButton(
                child: Text('Login', style: buttonStyle,),
                color: Colors.white.withOpacity(0.05),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
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
                                Navigator.pushNamed(context, "/home",
                                    arguments: _user);
                              } else {
                                Navigator.pop(context);
                              }
                            }),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 80.0,
            ),
            RichText(
              text: TextSpan(
                style: linkStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: 'Register!',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        }),
                ],
              ),
            ),
            SizedBox(
              height: 26.0,
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder _login() {
    return FutureBuilder<User>(
      future: login(_controller_username.text, _controller_password.text),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          _user = snapshot.data;
          _loginSucceed = true;
          return Text('You login as ${_user.username}');
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
