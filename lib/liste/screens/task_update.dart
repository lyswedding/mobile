import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/liste/components/add-list-input.dart';
import 'package:lys_wedding/liste/screens/list_tasks.dart';

import 'liste_page.dart';


class TaskUpdate extends StatefulWidget {
  const TaskUpdate({Key? key}) : super(key: key);

  @override
  _TaskUpdateState createState() => _TaskUpdateState();
}

class _TaskUpdateState extends State<TaskUpdate> {
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
            const SizedBox(
              height: 60,
            ),
            const AddListInput(
              titre: "Titre",
              hint: "Nom de tache",
            ),
            const AddListInput(
              titre: "Description",
              hint: "Description",
            ),
            const AddListInput(
              titre: "Cout",
              hint: "Cout",
            ),
            const AddListInput(
              titre: "Note",
              hint: "Note",
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomInput(
                hint: '22 Fev 2022',
                icon: Icon(EvaIcons.calendar),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CustomInput(
                hint: 'tags',
                icon: Icon(EvaIcons.pricetags),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: whiteColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListTasks()));
                    },
                    child: const Text(
                      "Enregistrer",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
          ]),
        ));
  }
}
