import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/favorite/components/listsfav.dart';
import 'package:lys_wedding/home/screens/favorite/components/title_pages.dart';
import 'package:lys_wedding/home/screens/liste/screens/add-list/screens/add-lists.dart';

class ListePage extends StatefulWidget {
  const ListePage({Key? key}) : super(key: key);

  @override
  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        TitlePages(title: "UserLists"),
        lists(height: 65, width: 40)
      ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddList(),
              ));
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
