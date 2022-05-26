import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/liste/components/add-list-input.dart';
import 'package:lys_wedding/UI/liste/components/task_component.dart';
import 'package:lys_wedding/UI/liste/screens/add_task.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController tagsController = TextEditingController();
bool isInCall = false;
final List<Task> tasks = [];
final List<String> tags = [];
late AnimationController animationController;

class _AddListState extends State<AddList> with TickerProviderStateMixin {
  _addList() async {
    setState(() {
      isInCall = false;
    });

    TaskList taskList = TaskList('0', titleController.text, descController.text,
        tasks, tags, '', 1000, 0);

    ListCalls.addTaskList(taskList).then((value) {
      print(value);
      if (value == 200) {
        showToast(context: context, msg: "liste créé avec succès!");
        setState(() {
          tags.clear();
          tasks.clear();
          titleController.clear();
          descController.clear();
        });
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });

    setState(() {
      isInCall = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Ajouter liste",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddListInput(
                    titre: "Titre",
                    hint: "Nom de liste",
                    textEditingController: titleController,
                    isEnabled: true,
                    textInputType: TextInputType.text,
                  ),
                  AddListInput(
                    titre: "Description",
                    hint: "Description",
                    textEditingController: descController,
                    isEnabled: true,
                    textInputType: TextInputType.text,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          'Tags',
                          style: titleTextStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor,
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFieldTags(
                                tagsStyler: TagsStyler(
                                    tagTextStyle: regularTextStyle.copyWith(
                                        color: primaryColor),
                                    tagDecoration: BoxDecoration(
                                      color: Colors.pink[300],
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    tagCancelIcon: Icon(Icons.cancel,
                                        size: 18.0, color: Colors.pink[900]),
                                    tagPadding: const EdgeInsets.all(6.0)),
                                textFieldStyler: TextFieldStyler(
                                    textFieldBorder: InputBorder.none,
                                    hintText: 'enter tags',
                                    hintStyle:
                                        regularTextStyle.copyWith(fontSize: 15),
                                    helperText: ''),
                                onTag: (tag) {
                                  tags.add(tag);
                                },
                                onDelete: (tag) {
                                  tags.remove(tag);
                                },
                                validator: (tag) {
                                  if (tag.length > 15) {
                                    return "hey that's too long";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Taches',
                          style: titleTextStyle.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0; i < tasks.length; i++)
                          _buildListTasks(i),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTask(
                                          taskList: tasks,
                                        )));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                alignment: Alignment.center,
                                // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: whiteColor,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      EvaIcons.plusSquareOutline,
                                      color: secondaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ajouter tache',
                                      style: regularTextStyle,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        text: 'Enregistrer',
                        onPressed: () {
                          if (titleController.text.isEmpty) {
                            showToast(context: context, msg: "verifie title ");
                          } else if (descController.text.isEmpty) {
                            showToast(
                                context: context, msg: "verifie description ");
                          } else if (tags.isEmpty) {
                            showToast(context: context, msg: "verifie tags ");
                          } else if (tasks.isEmpty) {
                            showToast(context: context, msg: "verifie tasks ");
                          } else {
                            _addList();
                            Navigator.pop(context);
                          }
                        }),
                  )
                ]),
          ),
        ));
  }

  _buildListTasks(int i) {
    var animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval((1 / 6) * 5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
    return TaskComponent(
      task: tasks[i],
      animationController: animationController,
      text: 'text',
      animation: animation,
    );
  }
}
