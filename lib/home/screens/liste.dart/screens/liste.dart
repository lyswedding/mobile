import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/favorite/component/listsfav.dart';
import 'package:lys_wedding/home/screens/favorite/component/title_pages.dart';

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
    ])));
  }
}
