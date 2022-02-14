import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/favorite/component/title_pages.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String valuechoose = 'Item 1';
  var Listitems = [
    "prestataire",
    "aaaa",
    "bbbb",
    "cccc",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TitlePages(title: "Favorite"),
      Container(
        child: DropdownButton(
          value: valuechoose,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: Listitems.map((String Listitems) {
            return DropdownMenuItem(
              value: Listitems,
              child: Text(Listitems),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(
              () {
                valuechoose = newValue!;
              },
            );
          },
        ),
      ),
      SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 800,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Container(
                height: 200,
                width: 50,
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orange),
              ),
            ),
          )
        ],
      ))
    ])));
  }
}
