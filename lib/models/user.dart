import 'package:meta/meta.dart';

class User {
  String id;
  String username;
  String email;
  String jwt;

  User(
      {@required this.id,
      @required this.username,
      @required this.email,
      @required this.jwt});

  factory User.fromJson(Map<String, dynamic> jsonUser) {
    return User(
        id: jsonUser['_id'],
        username: jsonUser['username'],
        email: jsonUser['email'],
        jwt: jsonUser['jwt']);
  }
}
