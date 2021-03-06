import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/models/user.dart';

// User login
Future<User> login(String username, String password) async {
  final http.Response response = await http.post(
    'https://jlee-sps-summer20.df.r.appspot.com/login',
    body: {
      'username': username,
      'password': password,
    },
  );
  if (response.statusCode >= 200 && response.statusCode <= 210) {
    return User.fromJson(json.decode(response.body));
  }
  else if (response.statusCode == 401) {
    throw Exception('Password incorrect!');
  }
  else if (response.statusCode == 404) {
    throw Exception('Username not found!');
  }
  else if (response.statusCode >= 500) {
    throw Exception('Server error');
  }
  else {
    throw Exception('Failed to login.');
  }
}

// User register
Future<User> createUser(String username, String password, String email) async {
  final http.Response response = await http.post(
    'https://jlee-sps-summer20.df.r.appspot.com/register',
    body: {
      'username': username,
      'password': password,
      'email': email,
    },
  );
  if (response.statusCode >= 200 && response.statusCode <= 210) {
    return User.fromJson(json.decode(response.body));
  }
  else if (response.statusCode == 400) {
    throw Exception('Inputs are empty or null');
  }
  else if (response.statusCode == 401) {
    throw Exception('This user has been registered');
  }
  else if (response.statusCode >= 500) {
    throw Exception('Server error');
  }
  else {
    throw Exception('Failed to create user.');
  }
}

// Fetch all event by userId
Future<List<Event>> fetchEvent(String userId) async {
  final response = await http.get(
      "https://tfang-sps-summer20.appspot.com/?userId=" + userId);
  if (response.statusCode >= 200 && response.statusCode <= 210) {
    List data = jsonDecode(response.body);
    return data.map((event) => new Event.fromJson(event)).toList();
  }
  else if (response.statusCode >= 500) {
    throw Exception('Server error');
  }
  else {
    throw Exception('Failed to load');
  }
}

// Create new event
Future<String> createEvent(String userId, String title, String startTime, String endTime, String content) async {
  final http.Response response = await http.post(
    "https://tfang-sps-summer20.appspot.com",
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
  else if (response.statusCode == 401) {
    throw Exception('startTime/endTime not possible');
  }
  else if (response.statusCode == 404) {
    throw Exception('title cannot be empty');
  }
  else if (response.statusCode >= 500) {
    throw Exception('Server error');
  }
  else {
    throw Exception('Failed to create event.');
  }
}

