import 'package:flutter/material.dart';
import '../fetch.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator (
      child: _eventData(),
      onRefresh: () async {
        print('refresh');
      },
    );
  }

  FutureBuilder _eventData() {
    return FutureBuilder<List<Event>>(
      future: fetchEvent(),
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
              child: _tile(
                  data[index].title, data[index].startTime, data[index].endTime,
                  Icons.calendar_today)
          );
        }
    );
  }

  ListTile _tile(String title, DateTime startTime, DateTime endTime,
      IconData icon) {
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(f.format(startTime) + ' ~ ' + f.format(endTime)),
      leading: Icon(
        icon,
        color: Colors.red[500],
      ),
    );
  }
}