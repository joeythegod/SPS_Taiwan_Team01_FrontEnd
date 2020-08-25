import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:io';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/models/friend.dart';
import 'package:first_flutter_project/screens/eventTab.dart';
import 'package:image_picker/image_picker.dart';

class calendarViewTab extends StatefulWidget {
  calendarViewTab({
    Key key,
    @required this.events,
    @required this.user,
    @required this.viewOnly,
    this.friend,
  }) : super(key: key);
  final List<Event> events;
  final User user;
  final bool viewOnly;
  final Friend friend;

  @override
  _calendarViewTabState createState() => _calendarViewTabState();
}

class _calendarViewTabState extends State<calendarViewTab>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  Map<DateTime, List<Event>> _eventInstances = {};
  List _selectedEvents;
  List<Event> _selectedInstances;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    DateTime date;
    for (Event event in widget.events) {
      date = DateTime.parse(event.startTime.substring(0, 10));
      if (!_events.containsKey(date)) {
        _events[date] = [];
        _eventInstances[date] = [];
      }
      _events[date].add(event.title);
      _eventInstances[date].add(event);
    }
    _selectedEvents = _events[_selectedDay] ?? [];
    _selectedInstances = _eventInstances[
    DateTime.parse(_selectedDay.toString().substring(0, 10) + " 00:00:00.000")];
    _calendarController = CalendarController();

    _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
    );

    _animationController.
    forward
    (
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
      _selectedInstances = _eventInstances[
      DateTime.parse(day.toString().substring(0, 10) + " 00:00:00.000")];
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(DateTime first, DateTime last,
      CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTableCalendarWithBuilders(),
        const SizedBox(height: 8.0),
        Expanded(child: _buildEventList()),
      ],
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'zh_ZH',
      calendarController: _calendarController,
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    if (_selectedInstances != null) {
      return eventTab(
        events: _selectedInstances, user: widget.user, viewOnly: widget.viewOnly,);
    }
    else {
      return Text("There is no event, enjoy the day :)");
    }
  }
}
