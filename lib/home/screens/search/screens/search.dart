import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/home/components/shared/item_row.dart';
import 'package:lys_wedding/home/screens/favorite/components/listsfav.dart';
import 'package:lys_wedding/home/screens/favorite/components/title_pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        const TitlePages(title: "search"),
        CustomInput(
          icon: Icon(Icons.search),
          hint: "search",
        ),
        // IconButton(
        //   icon: const Icon(Icons.tune),
        //   color: Colors.black,
        //   onPressed: () {},
        // ),
        ItemRow(
          height: 100,
          color: Colors.orange,
          width: 60,
          title: "Categories",
        ),
        Row(children: [
          Padding(padding: EdgeInsets.only(left: 16, top: 50, bottom: 10)),
          Text("Results"),
          Padding(padding: EdgeInsets.only(left: 250, top: 50, bottom: 0)),
          Text("view more")
        ]),
        Container(
          padding: EdgeInsets.only(top: 1),
          child: lists(
            height: 200,
            width: 200,
          ),
        )
      ]),
    ));
  }
}
