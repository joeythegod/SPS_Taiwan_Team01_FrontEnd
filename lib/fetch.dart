import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const url = 'https://5f212e69daa42f00166656c2.mockapi.io/api/v1/getEvents';

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

class Event {
  final String id;
  final String title;
  final DateTime timeStart;
  final DateTime timeEnd;

  Event({this.id, this.title, this.timeStart, this.timeEnd});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      timeStart: DateTime.fromMicrosecondsSinceEpoch(json['timeStart']*1000),
      timeEnd: DateTime.fromMicrosecondsSinceEpoch(json['timeEnd']*1000),
    );
  }
}