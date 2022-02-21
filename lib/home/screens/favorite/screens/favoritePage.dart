import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String valuechoose = 'prestataire';
  var Listitems = [
    "prestataire",
    "aaaa",
    "bbbb",
    "cccc",
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Favorite",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
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
