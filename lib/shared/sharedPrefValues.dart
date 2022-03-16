import 'package:shared_preferences/shared_preferences.dart';

saveAccessTokenSharedPref(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  // await prefs.setString('userid', userid);
}

getUserInfoSharedPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

deleteToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}
