import 'package:flutter/material.dart';
import '../fetch.dart';
import 'package:intl/intl.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: TabBar(
            labelPadding: EdgeInsets.zero,
            tabs: <Widget>[
              Tab(text: "Events"),
              Tab(text: "Calendar"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            Text("Calendar"),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Hello user!'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text("Sign out"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _eventData()
    );
  }

  FutureBuilder _eventData(){
    return FutureBuilder<List<Event>>(
      future: fetchEvent(),
      builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot){
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
              child: _tile(data[index].title, data[index].timeStart, data[index].timeEnd, Icons.calendar_today)
          );
        }
    );
  }

  ListTile _tile(String title, DateTime timeStart, DateTime timeEnd, IconData icon) {
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(f.format(timeStart) + ' ~ ' + f.format(timeEnd)),
      leading: Icon(
        icon,
        color: Colors.lightGreen[500],
      ),
    );
  }
}