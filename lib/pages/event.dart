import 'package:flutter/material.dart';
import '../fetch.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    Key key,
    @required this.userId,
  }) : super(key: key);
  final String userId;
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator (
      child: _eventData(),
      onRefresh: () async {
        fetchEvent(widget.userId);
      },
    );
  }

  FutureBuilder _eventData() {
    return FutureBuilder<List<Event>>(
      future: fetchEvent(widget.userId),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
        if (snapshot.hasData) {
          List<Event> data = snapshot.data;
          return _event(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  ListView _event(data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: _tile(data[index].title, data[index].startTime, data[index].endTime, Icons.calendar_today)
        );
      }
    );
  }

  ListTile _tile(String title, String startTime, String endTime, IconData icon) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(startTime + ' ~ ' + endTime),
      leading: Icon(
        icon,
        color: Colors.red[500],
      ),
    );
  }
}