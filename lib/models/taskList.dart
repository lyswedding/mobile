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

  String id;
  String title;
  String description;
  List<Task> tasks;
  List tags;
  String imageUrl;



  Map<String, dynamic> toJson() {
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

  // Map<String, dynamic> toJson() {
  //   //Map author = this.author != null ? this.author.toJson() : null;
  //   return <String, dynamic>{
  //     'title': title,
  //     'description': description,
  //     'doctor': doctor,
  //     'state': state,
  //     'responses': responsesJSon,
  //   };
  // }

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
