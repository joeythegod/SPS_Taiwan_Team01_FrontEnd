import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


//const url_user = 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/username';
const url_user = 'https://jlee-sps-summer20.df.r.appspot.com/';

//const url_event = 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/getEvents';
const url_event = "https://tfang-sps-summer20.appspot.com/";

// User Section
class User {
  final String username;
  final String password;
  final String email;
  final String userId;

  User({this.username, this.password, this.email, this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      userId: json['userId'],
    );
  }
}

Future<User> login(String username, String password) async {
  final http.Response response = await http.post(
    url_user+'login',
    body: {
      'username': username,
      'password': password,
    },
  );
  if (response.statusCode >= 200 && response.statusCode <= 210) {
    return User.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to login.');
  }
}

Future<User> createUser(String username, String password, String email) async {
  final http.Response response = await http.post(
    url_user+'register',
    body: {
      'username': username,
      'password': password,
      'email': email,
    },
  );
  if (response.statusCode >= 200 && response.statusCode <= 210) {
    return User.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to create user.');
  }
}

//Event
class Event {
  final String userId;
  final String title;
  final String startTime;
  final String endTime;
  final String content;

  Event({this.userId, this.title, this.startTime, this.endTime, this.content});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      userId: json['userId'],
      title: json['title'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      content: json['content'],
    );
  }
}

Future<List<Event>> fetchEvent(String userId) async {
  final response = await http.get(url_event + "?userId=" + userId);
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

Future<String> createEvent(String userId, String title, String startTime, String endTime, String content) async {
  final http.Response response = await http.post(
    url_event,
    body: {
      'userId': userId,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'content': content,
    },
  );

  if (response.statusCode >= 200 && response.statusCode <= 210) {
    return json.decode(response.body);
  }
  else {
    throw Exception('Failed to create event.');
  }
}

