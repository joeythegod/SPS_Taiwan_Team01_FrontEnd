import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const url_user = 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/username';
//const url_user = 'https://jlee-sps-summer20.df.r.appspot.com/login';
const url_event = 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/getEvents';

// User Section
class User {
  final String username;
  final String password;
  final String email;
  final String userid;

  User({this.username, this.password, this.email, this.userid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      userid: json['id'],
    );
  }
}

Future<User> login(String username, String password) async {
  final http.Response response = await http.post(
    url_user,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  // Should be 200 ok
  if (response.statusCode == 201) {
    return User.fromJson(json.decode(response.body));
  }
  else if (response.statusCode == 302) {
    print(response.headers['location']);
    throw Exception('Failed to redirect.');
  }
  else {
    throw Exception('Failed to login.');
  }
}

Future<User> createUser(String username, String password, String email) async {
  final http.Response response = await http.post(
    url_user,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
      'email': email,
    }),
  );
  if (response.statusCode == 201) {
    return User.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to create user.');
  }
}

//Event
class Event {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String content;

  Event({this.id, this.title, this.startTime, this.endTime, this.content});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.fromMicrosecondsSinceEpoch(json['startTime']*1000),
      endTime: DateTime.fromMicrosecondsSinceEpoch(json['endTime']*1000),
      content: json['content'],
    );
  }
}

Future<List<Event>> fetchEvent() async {
  final response = await http.get(url_event);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List data = jsonDecode(response.body);
    return data.map((event) => new Event.fromJson(event)).toList();
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

Future<Event> createEvent(String userid, String title, DateTime startTime, DateTime endTime, String content) async {
  final http.Response response = await http.post(
    url_event,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'userid': userid,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'content': content,
    }),
  );
  if (response.statusCode == 201) {
    return Event.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to create event.');
  }
}

