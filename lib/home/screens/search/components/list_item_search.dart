import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/search/screens/prestataire/screens/prestataire.dart';

class ItemListSearch extends StatelessWidget {
  const ItemListSearch({
    Key? key,
    required this.text,
    required this.items,
    required this.width,
    required this.height,
  }) : super(key: key);

  final List items;
  final String text;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items
              .map((element) => Container(
                    width: 380.0,
                    height: 280.0,
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                          )
                        ]),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Prestatairer()));
                        },
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      element,
                                      height: 200,
                                      width: 400,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      // Icon(Icons.favorite))),
                                    ))
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 1,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(right: 10)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 25, right: 10)),
                                          Text(
                                            text,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      )),
                                      Row(
                                        children: [
                                          Text("412"),
                                          Padding(padding: EdgeInsets.all(5)),
                                          Text("views",
                                              style:
                                                  TextStyle(color: Colors.grey))
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 12, bottom: 30)),
                                      Text("Coiffure ,maquillage",
                                          style: TextStyle(
                                              color: Colors.grey[600]))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 9)),
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        "1901 Thornridge Cir. Shiloh, Hawaii",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ))
              .toList()),
    );
  }
}
