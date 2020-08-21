import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:first_flutter_project/models/event.dart';



class eventInfoPage extends StatefulWidget {
  @override
  _eventInfoPageState createState() => _eventInfoPageState();
}

class _eventInfoPageState extends State<eventInfoPage> {
  @override
  Widget build(BuildContext context) {
    Event _event = ModalRoute.of(context).settings.arguments;
    String _markdownData = "";
    _markdownData += "# Time:\n#### _from_ _${_event.startTime}_\n\n";
    _markdownData += "#### _to_ _${_event.endTime}_\n";
    _markdownData += "# Note:\n${_event.content}\n";
    String imgUrl = "http://lh3.googleusercontent.com/sU0QZebG67gRFBKETSKNV3uPm9f7JQSD_yW_0jzmFfw-3Hp_RnG3GPlC0noaY0DJMiorn9bpCpXlmvfaLo8aiVjJ3l0Ljs56l9E";
    _markdownData += "# Image:\n![image](${imgUrl})\n";


    return Scaffold(
      appBar: AppBar(
        title: Text(_event.title),
      ),
      body: Scrollbar(
        child: Markdown(
          data: _markdownData,
        )
      )
    );
  }
}


