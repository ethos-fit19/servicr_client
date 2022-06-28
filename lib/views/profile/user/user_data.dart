import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image:
        "https://media.istockphoto.com/photos/happy-male-executive-in-office-picture-id1208414307?k=20&m=1208414307&s=612x612&w=0&h=6_K-g8mu8VMCh0TX3F4q3VORaFK_7tJD3PzubGHwdZs=",
    name: 'John Philip',
    email: 'johnphilip89@gmail.com',
    phone: '+94256984320',
    city: 'Kandy',
    other: '',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
