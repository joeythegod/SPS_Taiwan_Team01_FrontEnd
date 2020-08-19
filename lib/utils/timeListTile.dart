import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class timeListTile extends StatefulWidget {
  const timeListTile({
    Key key,
    @required this.title,
    @required this.controller_time,
  }) : super(key: key);

  final String title;
  final TextEditingController controller_time;
  @override
  _timeListTileState createState() => _timeListTileState();
}

class _timeListTileState extends State<timeListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.timer),
      title: Text('${widget.title}'),
      subtitle: Text('${widget.controller_time.text}'),
      onTap: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2018, 1, 1, 0, 0),
          maxTime: DateTime(2025, 12, 31, 23, 59),
          onChanged: (date) {
            print('change $date in time zone ');
          },
          onConfirm: (date) {
            print('confirm $date');
            setState(() {
              widget.controller_time.text =
              '${DateFormat('yyyy-MM-dd kk:mm').format(date)}';
            });
          },
          currentTime: DateTime.now(),
          locale: LocaleType.zh,
        );
      },
    );
  }
}