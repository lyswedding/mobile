import 'package:flutter/material.dart';

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
      child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: items
                  .map((element) => Container(
                        width: 380.0,
                        height: 280.0,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 0.5,
                                color: Colors.white,
                              )
                            ]),
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    element,
                                    height: 200,
                                    width: 400,
                                    fit: BoxFit.cover,
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
                                      Text(text),
                                      Row(
                                        children: const [
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
                                    children: const [
                                      Text("Coiffure ,maquillage",
                                          style: TextStyle(color: Colors.grey))
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.location_on_outlined),
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
                        ),
                      ))
                  .toList())),
    );
  }
}
