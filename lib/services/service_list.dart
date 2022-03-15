import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';

import '../../models/List_search.dart';

class ServiceList {
  static Future<List<Provider>> getPrestataire() async {
    final searchLists = <Provider>[];
    var base_url = "http://102.219.178.96:3001/providers";

    final response = await http.get(Uri.parse('${base_url}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for (var item in data['providers']) {
        searchLists.add(Provider.fromJson(item));
      }
    }
      return searchLists;


  }
}
