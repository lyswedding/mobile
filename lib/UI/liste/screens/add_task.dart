import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/liste/components/add-list-input.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'list_tasks.dart';
import 'liste_page.dart';

class AddTask extends StatefulWidget {
  final List<Task> taskList;
  AddTask({required this.taskList});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController nbUseController = TextEditingController();
  DateTime? datetime;

  String getText() {
    if (datetime == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd-MM-yyyy').format(datetime!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Add task",
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
              titre: "NbUse",
              hint: "NbUse",
              textEditingController: nbUseController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due date',
                    style: titleTextStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                    ),
                    child: GestureDetector(
                      child: Row(
                        children: [
                          const Icon(EvaIcons.calendarOutline),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            getText(),
                            style: regularTextStyle,
                          ),
                        ],
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate:
                              datetime == null ? DateTime.now() : datetime!,
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2040),
                        ).then((date) {
                          setState(() {
                            datetime = date;
                            print(datetime);
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tags',
                    style: titleTextStyle.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            CustomButton(
                text: 'Enregistrer',
                onPressed: () {
                  setState(() {
                    widget.taskList.add(Task(
                        titleController.text,
                        descController.text,
                        int.parse(costController.text),
                        int.parse(nbUseController.text),
                        getText(),
                        'in progress',
                        [tagsController.text]));
                  });
                  Navigator.pop(context);
                })
          ]),
        ));
  }
}
