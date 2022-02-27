import 'package:flutter/material.dart';
import 'package:lys_wedding/home/components/item_list.dart';
import 'package:lys_wedding/home/components/list_images.dart';
import 'package:lys_wedding/home/screens/search/screens/prestataire/components/list_detail_prest.dart';

class Prestatairer extends StatefulWidget {
  const Prestatairer({Key? key}) : super(key: key);

  @override
  _PrestatairerState createState() => _PrestatairerState();
}

class _PrestatairerState extends State<Prestatairer> {
  List items = [
    "images/4.jpg",
    "images/3.jpg",
    "images/2.jpg",
    "images/4.jpg",
    "images/5.jpg",
    "images/6.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Detail",
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 250,
                margin: EdgeInsets.all(10),
                child: Column(children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 30,
                        ),
                        // Icon(Icons.favorite))),
                      )),
                ]),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        image: AssetImage("images/11.jpg"), fit: BoxFit.fill)),
              ),
              Row(children: [
                Padding(padding: EdgeInsets.only(left: 23, bottom: 30)),
                Text(
                  "FLOYD MILES",
                  style: TextStyle(fontSize: 20),
                )
              ]),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                    left: 20,
                  )),
                  Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                  Text(
                    "1901 Thornridge Cir. Shiloh, Hawaii",
                    style: TextStyle(),
                  )
                ],
              ),
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(left: 25, bottom: 30, top: 20)),
                Text(
                  "mariage,decoration..",
                  style: TextStyle(color: Colors.grey),
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset("images/17.png"),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset("images/18.png"),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset("images/19.png"),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "images/20.png",
                    scale: 1,
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20, right: 20)),
                    Text(
                      "Text(String data, {Key? key, TextStyle? style,\n StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? \ntextDirection, Locale? locale, bool? softWrap,\n ",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 22, top: 10, bottom: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Photos",
                      style: TextStyle(fontSize: 20),
                    )),
              ),
              ItemListPrest(text: "", items: items, width: 150, height: 150),
              Padding(
                padding: EdgeInsets.only(left: 22, top: 10, bottom: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "People also saw",
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
            ],
          ),
        ));
  }
}
