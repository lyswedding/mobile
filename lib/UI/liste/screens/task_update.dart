import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/liste/components/add-list-input.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'list_tasks.dart';
import 'liste_page.dart';


class TaskUpdate extends StatefulWidget {
  const TaskUpdate({required this.task,required this.idList});
  final Task task;
  final String idList;

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
  List<String> tags=[];
  DateTime? datetime;
  bool isEnabled=false;
  bool isInCall=false;

  String getText() {
    if (datetime == null) {
      return widget.task.dueDate;
    } else {
      return DateFormat('dd-MM-yyyy').format(datetime!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    titleController.text=widget.task.title;
    descController.text=widget.task.description;
    dueDateController.text=widget.task.dueDate;
    costController.text=widget.task.cost.toString();
    //tags=widget.task.tags as List<String>;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              setState(() {
                isEnabled=!isEnabled;
              });
            }, icon: Icon(Icons.edit,color: primaryColor,)),
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
               isEnabled: isEnabled,
            ),
             AddListInput(
              titre: "Description",
              hint: "Description",
               textEditingController: descController,
               isEnabled: isEnabled,
             ),
             AddListInput(
              titre: "Cout",
              hint: "Cout",
               textEditingController: costController,
               isEnabled: isEnabled,
             ),
             AddListInput(
              titre: "Note",
              hint: "Note",
               textEditingController:nbUseController,
               isEnabled: isEnabled,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tags',
                  style: titleTextStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFieldTags(
                        initialTags: [widget.task.tags[0].toString()],
                          tagsStyler: TagsStyler(
                              tagTextStyle: regularTextStyle.copyWith(color: primaryColor),
                              tagDecoration: BoxDecoration(color: Colors.pink[300], borderRadius: BorderRadius.circular(5.0), ),
                              tagCancelIcon: Icon(Icons.cancel, size: 18.0, color: Colors.pink[900]),
                              tagPadding: const EdgeInsets.all(6.0)
                          ),
                          textFieldStyler: TextFieldStyler(
                              textFieldBorder: InputBorder.none,
                              hintText: 'enter tags',
                              hintStyle: regularTextStyle.copyWith(fontSize: 15),
                              helperText: ''
                          ),
                          onTag: (tag) {
                            tags.add(tag);
                          },
                          onDelete: (tag) {
                            tags.remove(tag);
                          },
                          validator: (tag){
                            if(tag.length>15){
                              return "hey that's too long";
                            }
                            return null;
                          }
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            CustomButton(text: 'Enregistrer', onPressed: (){
              _updateTaskList();
             // Navigator.pop(context);

            })
          ]),
        ));
  }

  _updateTaskList(){
    setState(() {
      isInCall = false;
    });

    Task task  = Task(widget.task.id,titleController.text,descController.text,int.parse(costController.text),widget.task.nbUse,DateTime.now().toIso8601String(),widget.task.state,widget.task.tags);

   ListCalls.editTaskInList(task,widget.task.id,widget.idList).then((value) {
     showToast(context: context, msg: 'tache modifié avec succés');
     Navigator.pop(context);
   });

    setState(() {
      isInCall = true;
    });

  }
}
