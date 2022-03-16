import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../shared/sharedPrefValues.dart';
import '../../../shared/urls.dart';
import '../modele/model_profil.dart';

class ServiceProfil {
  ServiceProfil() {}
  Future<UserApi> getUser() async {
    final profil = <User>[];
    UserApi userapi;
    var url = Uri.parse('${URLS.BASE_URL}/users/me');
    var token = await getUserInfoSharedPref("token");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token ',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(response.body);
      userapi = UserApi.fromJson(data);
    } else {
      print(response.body);

      throw Exception('not found');
    }
    return userapi;
  }
}
