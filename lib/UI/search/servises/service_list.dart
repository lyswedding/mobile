import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/List_search.dart';
import '../components/list_item_search.dart';

class ServiceList {
  var base_url = "http://102.219.178.96:3001/providers";
  ServiceList() {}
  Future<ListSearch> getPrestataire() async {
    try {
      final responce = await http.get(Uri.parse('${base_url}'));
      if (responce.statusCode == 200) {
        final data = ListSearch.fromJson(json.decode(responce.body));
        return data;
      } else {
        return ListSearch(providers: [], success: true);
      }
    } catch (e) {
      print("erreur de consommation : $e");
      return ListSearch(providers: [], success: false);
    }
  }
}
