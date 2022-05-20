import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class TaskList {
  TaskList(
    this.id,
    this.title,
    this.description,
    this.tasks,
    this.tags,
    this.imageUrl,
    this.cost,
    this.nbUse,
  );

  String? id;
  String? title;
  String? description;
  List<Task>? tasks;
  List tags;
  String? imageUrl = '';
  int nbUse = 0;
  int cost = 1000;

  Map<String, dynamic> toJson() {
    var responsesJSon = (tasks!.map((i) => i.toJson()).toList());
    print(responsesJSon);

    return <String, dynamic>{
      'title': title,
      'description': description,
      'tags': tags,
      'tasks': responsesJSon,
      'nbr_use': nbUse,
      'realization_date': DateTime.now().toIso8601String(),
      'cost': cost,
      'image': imageUrl
    };
  }

  factory TaskList.fromJson(Map<String, dynamic> json) {
    var lists = json['tasks'] as List;

    List<Task> tasksList = lists.map((i) => Task.fromJson(i)).toList();

    return TaskList(
        json['_id'].toString(),
        json['title'].toString(),
        json['description'].toString(),
        tasksList,
        json['tags'],
        json['imageUrl'],
        json['nbr_use'],
        json['cost']);
  }
}

class Task {
  Task(
    this.id,
    this.title,
    this.description,
    this.cost,
    this.nbUse,
    this.dueDate,
    this.state,
    this.tags,
  );

  String title;
  String description;
  int cost;
  int nbUse;
  String dueDate;
  String state;
  List tags;
  String id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "title": title,
      "description": description,
      "cost": cost,
      "realization_date": dueDate,
      "tags": tags,
      "nbr_use": 0,
      "state": "IN PROGRESS"
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    List listO = json['tags'];
    print(json['realization_date']);
    DateTime dateTime = json['realization_date'] != null
        ? DateTime.parse(json['realization_date'].toString())
        : DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return Task(
      json['_id'].toString(),
      json['title'].toString(),
      json['description'].toString(),
      json['cost'],
      json['nbr_use'],
      formattedDate,
      json['state'],
      listO,
    );
  }
}
