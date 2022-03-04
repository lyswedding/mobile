import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/liste/components/add-list-input.dart';
import 'package:lys_wedding/UI/liste/components/task_component.dart';
import 'package:lys_wedding/UI/liste/screens/add_task.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/task_list_services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'liste_page.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descController = TextEditingController();
TextEditingController tagsController = TextEditingController();
bool isInCall = false;
List<Task> tasks = [];

class _AddListState extends State<AddList> {
  _addList() async {
    setState(() {
      isInCall = false;
    });
    var body = {
      "title": titleController.text,
      "description": descController.text,
      "tags": tagsController.text
    };
    ListCalls.addResponse(body).then((value) => print(value));

    setState(() {
      isInCall = true;
    });
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListePage()));
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60,
                ),
                AddListInput(
                  titre: "Titre",
                  hint: "Nom de liste",
                  textEditingController: titleController,
                ),
                AddListInput(
                  titre: "Description",
                  hint: "Description",
                  textEditingController: descController,
                ),
                Text(
                  'taches',
                  style: titleTextStyle.copyWith(fontSize: 14),
                ),
                Text(tasks.length.toString()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                            alignment: Alignment.center,
                            // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor,
                            ),
                            child: Row(
                              children: const [
                                Icon(EvaIcons.plusSquareOutline),
                                Text('ajouter tache'),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                      text: 'Enregistrer',
                      onPressed: () {
                        _addList();
                      }),
                )
              ]),
        ));
  }
}
