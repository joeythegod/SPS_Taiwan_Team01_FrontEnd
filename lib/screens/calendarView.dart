import "package:flutter/material.dart";
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:first_flutter_project/models/event.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/models/friend.dart';
import 'package:first_flutter_project/https/api.dart';
import 'package:image_picker/image_picker.dart';

class calendarViewTab extends StatefulWidget {
  const eventTab({
    Key key,
    @required this.events,
  }) : super(key: key);


  @override
  _eventTabState createState() => _eventTabState();
}

class _eventTabState extends State<eventTab> {
  @override
  Widget build(BuildContext context) {


}
