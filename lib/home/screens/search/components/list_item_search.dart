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
                            boxShadow: [
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
                                // Align(
                                //   alignment: Alignment.bottomLeft,
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.only(
                                //         bottomLeft: Radius.circular(5.0),
                                //         bottomRight: Radius.circular(5.0),
                                //       ),
                                //     ),
                                //     child: Column(
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Padding(
                                //               padding: const EdgeInsets.only(
                                //                   bottom: 40.0,
                                //                   top: 10,
                                //                   left: 5),
                                //               child: Text(
                                //                 text,
                                //                 textAlign: TextAlign.center,
                                //                 style: TextStyle(
                                //                     color: Colors.black,
                                //                     fontFamily: 'IranSansLight',
                                //                     fontSize: 15.0),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // Align(
                                //     alignment: Alignment.bottomLeft,
                                //     child: Row(
                                //       children: [
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //               bottom: 60.0, top: 10, left: 8),
                                //         ),
                                //         Icon(Icons.location_on_outlined),
                                //         Text(
                                //           "Coiffure ,maquillage ",
                                //           textAlign: TextAlign.left,
                                //           style: TextStyle(
                                //               color: Colors.grey,
                                //               fontFamily: 'IranSansLight',
                                //               fontSize: 15.0),
                                //         ),
                                //       ],
                                //     )),
                                // Align(
                                //     alignment: Alignment.bottomLeft,
                                //     child: Row(
                                //       children: [
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //               bottom: 40.0, top: 10, left: 8),
                                //         ),
                                //         Icon(Icons.location_on_outlined),
                                //         Text(
                                //           "1901 Thornridge Cir. Shiloh, Hawaii ",
                                //           textAlign: TextAlign.left,
                                //           style: TextStyle(
                                //               color: Colors.grey,
                                //               fontFamily: 'IranSansLight',
                                //               fontSize: 15.0),
                                //         ),
                                //       ],
                                //     )),
                                // Align(
                                //     alignment: Alignment.bottomLeft,
                                //     child: Row(
                                //       children: [
                                //         Padding(
                                //             padding: EdgeInsets.only(
                                //                 left: 130, bottom: 100)),
                                //         Icon(Icons.ac_unit),
                                //         Text(
                                //           "text",
                                //           textAlign: TextAlign.left,
                                //           style: TextStyle(
                                //               color: Colors.grey,
                                //               fontFamily: 'IranSansLight',
                                //               fontSize: 15.0),
                                //         ),
                                //       ],
                                //     )),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.favorite)),
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
                                    children: [Text("data"), Text("data")],
                                  ),
                                  Row(
                                    children: [Text("Coiffure ,maquillage")],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      Text(
                                          "1901 Thornridge Cir. Shiloh, Hawaii")
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
