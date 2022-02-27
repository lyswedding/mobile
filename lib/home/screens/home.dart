import 'package:flutter/material.dart';
import 'package:lys_wedding/home/components/item_list.dart';
import 'package:lys_wedding/home/components/list-images.dart';
import 'package:lys_wedding/home/components/shared/item_row.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  List items = [
    "images/10.jpg",
    "images/3.jpg",
    "images/2.jpg",
    "images/4.jpg",
    "images/5.jpg",
    "images/6.jpg",
  ];
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
          leading: Container(
            //  Transform.translate(
            // offset: const Offset(10, 0),
            padding: EdgeInsets.only(top: 10),
            // margin: EdgeInsets.symmetric(vertical: 5),

            child: Image.asset(
              "images/adel.png",
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
              margin: const EdgeInsets.fromLTRB(30, 30, 10, 0),
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

            Padding(
              padding: EdgeInsets.only(left: 22, top: 10, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Categorie",
                    style: TextStyle(fontSize: 20),
                  )),
            ),

            ItemList(
                items: items,
                height: 150.0,
                width: 150.0,
                text:
                    "Jane Cooper\n 1901 Thornridge Cir. Shiloh, Hawaii\n Coiffure ,maquillage  "),
            Padding(
              padding: EdgeInsets.only(left: 22, top: 10, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Bon plan",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            ItemList(
              text:
                  "Jane Cooper\n 1901 Thornridge Cir. Shiloh, Hawaii\n Coiffure ,maquillage  ",
              items: items,
              height: 150.0,
              width: 250.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22, top: 10, bottom: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Listes populaires",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
            ItemList2(
                text: 'Lorem ipsem', items: items, width: 200, height: 250)

            // ItemRow(
            //   height: 100,
            //   color: Colors.orange,
            //   width: 60,
            //   title: "Categories",
            //   images: [],
            // ),
            // ItemRow(
            //   color: Colors.orange,
            //   height: 180,
            //   width: 250,
            //   title: "Bon Plans",
            //   images: [2],
            // ),
            // ItemRow(
            //   color: Colors.orange,
            //   height: 180,
            //   width: 180,
            //   title: "Popular Lists",
            //   images: [3],
            // ),
          ]),
        ));
  }
}

// class ItemList extends StatelessWidget {
//   const ItemList({
//     Key? key,
//     required this.text,
//     required this.items,
//     required this.width,
//     required this.height,
//   }) : super(key: key);

//   final List items;
//   final String text;
//   final double width, height;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: items
//             .map((element) => Container(
//                   width: width,
//                   height: height,
//                   child: Align(
//                       alignment: Alignment.bottomCenter, child: Text(text)),
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage(element),
//                       )),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
