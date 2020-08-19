class Event {
  final String userId;
  final String title;
  final String startTime;
  final String endTime;
  final String content;
  final String eventId;

  Event({this.userId, this.title, this.startTime, this.endTime, this.content, this.eventId});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      userId: json['userId'],
      title: json['title'],
      startTime: json['startTime'].substring(0, 16),
      endTime: json['endTime'].substring(0, 16),
      content: json['content'],
      eventId: json['eventId'],
    );
  }
}