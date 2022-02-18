import 'package:flutter/material.dart';
import 'package:lys_wedding/home/components/shared/item_row.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            "Bonjour",
            style: TextStyle(color: Colors.black),
          ),
          leading: Transform.translate(
            offset: const Offset(10, 0),
            child: Image.asset(
              "images/icon.png",
              height: 50,
            ),
          ),
          actions: const <Widget>[
            Icon(
              Icons.search,
              color: Colors.black,
              size: 24,
            ),
            Padding(padding: EdgeInsets.all(10)),
            Icon(
              Icons.notifications,
              color: Colors.black,
              size: 24,
            ),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // TItleForPage(),
            Container(
              height: 150,
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: const Center(
                child: Text(
                  "We are here to help you planning your wedding",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: AssetImage("images/11.jpg"), fit: BoxFit.fill)),
            ),
            const ItemRow(
              height: 100,
              color: Colors.orange,
              width: 60,
              title: "Categories",
              Image: Image(image: AssetImage("images/11.jpg")),
            ),
            const ItemRow(
              color: Colors.orange,
              height: 180,
              width: 250,
              title: "Bon Plans",
              Image: AssetImage("images/10.jpg"),
            ),
            const ItemRow(
              color: Colors.orange,
              height: 180,
              width: 180,
              title: "Popular Lists",
              Image: AssetImage("images/12.jpg"),
            ),
          ]),
        ));
  }
}
