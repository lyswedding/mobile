import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/home/screens/favorite/components/title_pages.dart';
import 'package:lys_wedding/home/screens/liste/screens/add-list/components/add-list-input.dart';

import '../../liste.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  _AddListState createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        TitlePages(title: "Ajouter list"),
        SizedBox(
          height: 60,
        ),
        AddListInput(
          titre: "Titre",
          hint: "Nom de liste",
        ),
        AddListInput(
          titre: "Description",
          hint: "Description",
        ),
        AddListInput(
          titre: "Taches",
          hint: "LOrem ipsum dolor ...",
        ),
        AddListInput(
          titre: "",
          hint: "Ajouter une tache",
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListePage()));
                },
                child: Text(
                  "Enregistrer",
                  style: TextStyle(fontSize: 20),
                ),
              )),
        ),
      ]),
    ));
  }
}
