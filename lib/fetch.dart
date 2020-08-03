import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/getEvents';
const url2= 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/username';



Future<List<Event>> fetchEvent() async {
  final response = await http.get(url);

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

Future<User> createUser(String username, String password, String email) async {
  final http.Response response = await http.post(
    url2,
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
  } else {
    throw Exception('Failed to create user.');
  }
}

class User {
  final String username;
  final String password;
  final String email;

  User({this.username, this.password, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }
}

class Event {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;

  Event({this.id, this.title, this.startTime, this.endTime});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      startTime: DateTime.fromMicrosecondsSinceEpoch(json['startTime']*1000),
      endTime: DateTime.fromMicrosecondsSinceEpoch(json['endTime']*1000),
    );
  }
}