import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';
import 'package:http/http.dart' as http;

class ListCalls {
  static Future<List<TaskList>> getAdminLists() async {
    var url;
    var response;
    final tasksLists = <TaskList>[];
    url = Uri.parse('${URLS.BASE_URL}/taskslists');
    response = await http.get(url, headers: {
      "Content-type": "application/json",
    });
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      for (var item in data['tasksLists']) {
        tasksLists.add(TaskList.fromJson(item));
      }
    }
    return tasksLists.toList();
  }
}
