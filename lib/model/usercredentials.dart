import 'dart:convert';

class UserCredentials {
  late String email;
  late String password;

  UserCredentials({required this.email, required this.password});

  toJson() {
    final loginData = {"email": email, "password": password};
    return json.encode(loginData);
  }
}
