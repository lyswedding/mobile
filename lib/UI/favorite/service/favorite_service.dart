import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lys_wedding/models/List_search.dart';

import '../modele/model_favorite.dart';

class ServiceFavorite {
  var base_url = "http://102.219.178.96:3001/providers/favorites";
  ServiceFavorite() {}
  Future<List<ServiceProvider>> getPrestFav() async {
    final listFav = <ServiceProvider>[];
    final response = await http.get(Uri.parse(base_url), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMWNjZDZkODQ1NGZjZjFmMTI4MGY0YyIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNjQ2Njc1NzEzLCJleHAiOjE2NDY3NjIxMTN9.8JWA62clOAYZMfNREUMtWB8OGOdlv90C0_6IZ2IWsmU',
    });
    print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var item in data['providers']) {
        listFav.add(ServiceProvider.fromJson(item));
        print(listFav);
      }
    }
    return listFav;
  }
}
