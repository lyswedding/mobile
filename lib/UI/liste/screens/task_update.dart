import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/liste/components/add-list-input.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'list_tasks.dart';
import 'liste_page.dart';


class TaskUpdate extends StatefulWidget {
  TaskUpdate({required this.task});
  final Task task;

  @override
  _TaskUpdateState createState() => _TaskUpdateState();

}


class _TaskUpdateState extends State<TaskUpdate> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descController =TextEditingController();
  TextEditingController dueDateController =TextEditingController();
  TextEditingController costController =TextEditingController();
  TextEditingController tagsController =TextEditingController();
  TextEditingController nbUseController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    titleController.text=widget.task.title;
    descController.text=widget.task.description;
    dueDateController.text=widget.task.dueDate;
    costController.text=widget.task.cost.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: primaryColor,)),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "task update",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
             AddListInput(
              titre: "Titre",
              hint: "Nom de tache",
              textEditingController: titleController,
            ),
             AddListInput(
              titre: "Description",
              hint: "Description",
               textEditingController: descController,
            ),
             AddListInput(
              titre: "Cout",
              hint: "Cout",
               textEditingController: costController,
            ),
             AddListInput(
              titre: "Note",
              hint: "Note",
               textEditingController:nbUseController,
            ),
             Padding(
              padding: EdgeInsets.all(16.0),
              // child: CustomInput(
              //   hint: '22 Fev 2022',
              //   icon: Icon(EvaIcons.calendar),
              //   controller: dueDateController,
              // ),
            ),
             Padding(
              padding: EdgeInsets.all(16.0),
              // child: CustomInput(
              //   hint: 'tags',
              //   icon: Icon(EvaIcons.pricetags),
              //   controller: tagsController,
              // ),
            ),
            CustomButton(text: 'Enregistrer', onPressed: (){
              Navigator.pop(context);

            })
          ]),
        ));
  }
}
