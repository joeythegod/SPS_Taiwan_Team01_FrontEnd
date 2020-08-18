class User {
  final String username;
  final String password;
  final String email;
  final String userId;

  User({this.username, this.password, this.email, this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      userId: json['userId'],
    );
  }
}