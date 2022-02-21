import 'package:flutter/material.dart';

class ItemList2 extends StatelessWidget {
  const ItemList2({
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
      scrollDirection: Axis.horizontal,
      child: Card(
          child: Row(
              children: items
                  .map((element) => Container(
                        width: 200.0,
                        height: 250.0,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.5,
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0),
                              )
                            ]),
                        child: Center(
                            child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                element,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5.0),
                                    bottomRight: Radius.circular(5.0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 40.0, top: 10, left: 5),
                                      child: Text(
                                        text,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'IranSansLight',
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 40.0, top: 10, left: 8),
                                    ),
                                    Icon(Icons.ac_unit),
                                    Text(
                                      text,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'IranSansLight',
                                          fontSize: 15.0),
                                    ),
                                  ],
                                )),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 130, bottom: 100)),
                                    Icon(Icons.ac_unit),
                                    Text(
                                      "text",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'IranSansLight',
                                          fontSize: 15.0),
                                    ),
                                  ],
                                )),
                            Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.favorite)),
                          ],
                        )),
                      ))
                  .toList())),
    );
  }
}
