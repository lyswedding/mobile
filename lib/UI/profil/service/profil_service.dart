import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modele/model_profil.dart';

class ServiceProfil {
  String base_url = "http://102.219.178.96:3001/users/621ccd6d8454fcf1f1280f4c";
  ServiceProfil() {}
  Future<UserApi> getUser() async {
    final profil = <User>[];
    UserApi userapi;

    final response = await http.get(Uri.parse(base_url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMWNjZDZkODQ1NGZjZjFmMTI4MGY0YyIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNjQ2NTk1MDUxLCJleHAiOjE2NDY2ODE0NTF9.hoQ3UD9UIwQ2x0i9qjyEF7csfL0Hbrxa27o1CXQT1Xw',
    });

    if (response.statusCode == 200) {
      print("jawk fesfes");
      final data = json.decode(response.body);
      print(data);
      //!
      userapi = UserApi.fromJson(data);
      // print("holaaaaaaaaaaa   " + userapi.user.lastName);
    } else {
      throw Exception('not found');
    }
    return userapi;
  }
}
