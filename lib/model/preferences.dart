import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();
  late SharedPreferences _sharedPreferences;
  static const String userNameKey = 'user_name';
  static const tokenKey = 'app_token';

  factory Preferences() {
    return _preferences;
  }

  Preferences._internal();

  initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  set userName(String name) {
    _sharedPreferences.setString(userNameKey, name);
  }

  set token(String token) {
    _sharedPreferences.setString(tokenKey, token);
  }
}
