import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskList {
  TaskList(
    this.id,
    this.title,
    this.description,
    this.tasks,
    this.tags,
      this.imageUrl,
  );

  final String? id;
  final String? title;
  final String? description;
  final List<Task>? tasks;
  final List? tags;
  final String? imageUrl;



  Map<String, dynamic> toJson() {

    List<Map<String, dynamic>>? responsesJSon =
    tasks != null ? tasks!.map((i) => i.toJson()).toList() : null;
    return <String, dynamic>{
      'title': title,
      'description': description,
      'tags': tags,
      'tasks':tasks
    };
  }

  factory TaskList.fromJson(Map<String, dynamic> json) {
    var lists = json['tasks'] as List;

    List<Task> tasksList = lists.map((i) => Task.fromJson(i)).toList();

    return TaskList(json['_id'].toString(), json['title'].toString(),
        json['description'].toString(), tasksList, json['tags'],json['imageUrl']);
  }
}

class Task {
  Task(
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "title": title,
      "description": description,
      "cost": cost,
      "realization_date": dueDate.toString(),
      "tags": tags
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    List listO = json['tags'];
    DateTime dateTime = DateTime.parse(json['realization_date'].toString());
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return Task(
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
