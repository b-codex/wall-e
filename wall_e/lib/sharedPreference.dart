import 'package:shared_preferences/shared_preferences.dart';

class sharedPreference {
  Future saveUsername(String username) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('username', username);
    return "Username Saved";
    // print('Username ($username) has been saved to shared preferences');
  }

  Future getUsername() async {
    final preferences = await SharedPreferences.getInstance();
    String? username = await preferences.getString('username');
    // print('Getting ($username) from shared preferences');
    return username;
  }

  Future removeUsername() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    return "Username Removed";
  }
}
