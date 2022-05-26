import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;
import 'package:lys_wedding/models/service.dart';

class CategorieCalls {
  static Future<List<Service>> getAdminServices() async {
    var url;
    var response;
    final servicesLists = <Service>[];
    url = Uri.parse('${URLS.BASE_URL}/services');
    response = await http.get(url, headers: {
      "Content-type": "application/json",
    });
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for (var item in data['services']) {
        var service = Service.fromJson(item);
        service.icon = URLS.BASE_URL + service.icon;
        servicesLists.add(service);
      }
    }
    return servicesLists.toList();
  }
}
