import 'package:first_flutter_project/models/friend.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/screens/drawer.dart';
import 'package:first_flutter_project/https/api.dart';

class friendListPage extends StatefulWidget {
  @override
  _friendListPageState createState() => _friendListPageState();
}

class _friendListPageState extends State<friendListPage> {
  @override
  Widget build(BuildContext context) {
    User _user = ModalRoute.of(context).settings.arguments;
    dynamic friendList = _fetchFriend(_user);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text("Friend List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                friendList = _fetchFriend(_user);
              });
            },
          )
        ],
      ),
      body: Container(
          child: friendList,
      ),
      drawer: drawerPage(user: _user),
    );
  }


  FutureBuilder _fetchFriend(User user) {
    return FutureBuilder<List<Friend>>(
      future: fetchFriend(user.userId),
      builder: (BuildContext context, AsyncSnapshot<List<Friend>> snapshot) {
        if (snapshot.hasData) {
          List<Friend> friends = snapshot.data;
          return _friendListtile(user, friends);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _friendListtile(User user, List<Friend> friends) {
    return ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          return Card(
              child: _tile(user, friends[index], Icons.person)
          );
        }
    );
  }

  ListTile _tile(User user, Friend friend, IconData icon) {
    return ListTile(
      title: Text(friend.username,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/friendEvent", arguments: {"user": user, "friend": friend});
      },
    );
  }
}
