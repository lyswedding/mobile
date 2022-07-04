import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/List_search.dart';

class RelatedList {
  static Future<List<ServiceProvider>> getPrestataire(String id) async {
    final searchLists = <ServiceProvider>[];
    var base_url = "http://102.219.178.96:3001/providers/related/";

    final response = await http.get(Uri.parse('${base_url}' + id));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      for (var item in data['providers']) {
        var provider = ServiceProvider.fromJson(item);
        print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
        provider.cover = "http://102.219.178.96:3001" + provider.cover;
        List<String> imgs = [];
        for (var img in provider.images) {
          img = "http://102.219.178.96:3001" + img;
          imgs.add(img);
        }
        provider.images = imgs;
        searchLists.add(provider);
      }
      print('zzzzzzzzzzzzzzzzzz');
      print(searchLists);
    }
    return searchLists;
  }
}
