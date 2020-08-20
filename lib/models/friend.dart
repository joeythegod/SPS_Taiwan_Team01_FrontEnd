class Friend {
  final String username;
  final String userId;

  Friend({this.username, this.userId});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      username: json['username'],
      userId: json['userId'],
    );
  }
}