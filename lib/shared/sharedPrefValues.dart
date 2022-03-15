import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveAccessTokenSharedPref(String token,String cookie) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
 await prefs.setString('cookie', cookie);
}

getUserInfoSharedPref(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

deleteToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove('token');
}
