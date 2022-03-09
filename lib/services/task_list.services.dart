import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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

  static Future<http.Response> addTaskList(TaskList task) async {
    var url;
    var response;

    url = Uri.parse('${URLS.BASE_URL}/taskslists');

    var token = await getUserInfoSharedPref("token");
    log(jsonEncode(task.toJson()));
    response = await http.post(
      url,
      body: jsonEncode(task.toJson()),
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  static Future addTaskListMultipartRequest(TaskList taskList) async {
    var url = Uri.parse('${URLS.BASE_URL}/taskslists');
    final response;
    final data = taskList.toJson();
    try {
      var token = await getUserInfoSharedPref("token");

      var request = http.MultipartRequest('POST', url);
      request = jsonToFormData(request, data);
      //print(jsonToFormData(request, data));
      request.headers['Authorization'] = "Bearer $token";

        // request.files
        //     .add(await http.MultipartFile.fromPath("image",'C:/Users/Administrateur/Downloads/carolyn-christine-aY7iXtGQ81E-unsplash.jpg'));

      response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      print(responseString);
      return responseString;
    } catch (error) {
      print('Error add project $error');
      throw (error);
    }
  }

  static jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {

      request.fields[key] = data[key].toString();
      print(data[key].toString());
    }
    return request;
  }


  static Future<TaskList> editTaskInList(Task task,idTask,idTaskList) async {
    var url;
    var response;

     url = Uri.parse('${URLS.BASE_URL}/taskslists/$idTaskList/task/$idTask');
      await getUserInfoSharedPref("token").then((token) async {
        response = await http.patch(
          url,
          body: jsonEncode(task.toJson()),
          headers: {
            "Content-type": "application/json",
            'Authorization': 'Bearer $token',
          },
        );
      });

    debugPrint('------------' + response.body);
    return response;
  }

  static Future<http.Response> deletTaskListFromTaskList(idList,idTask) async {
    var url;
    var response;

    url = Uri.parse('${URLS.BASE_URL}/taskslists/$idList/task/$idTask');

    var token = await getUserInfoSharedPref("token");
    response = await http.delete(
      url,
      headers: {
        "Content-type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

}
