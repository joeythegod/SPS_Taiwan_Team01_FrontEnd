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