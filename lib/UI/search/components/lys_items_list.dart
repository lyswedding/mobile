import 'package:flutter/material.dart';

class LysItem {
  LysItem({required this.label, required this.image});
  String label;
  String image;
}

class LysItemsList extends StatelessWidget {
  LysItemsList({Key? key, required this.items}) : super(key: key);
  List<LysItem> items = [];

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Scaffold(body: Text("loading..."));
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: items
            .map((element) => Container(
                  margin: EdgeInsets.only(top: 70),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                          height: 150,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              image: new DecorationImage(
                                image: new AssetImage(element.image),
                                fit: BoxFit.fill,
                              )),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 50),
                                      height: 50,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.red),

                                      // Padding(padding: EdgeInsets.all(10)),
                                      child: Container(
                                          child: InkWell(
                                        child: Text(element.label),
                                      )),
                                      // Padding(padding: EdgeInsets.all(10)),
                                    )),
                                Padding(padding: EdgeInsets.all(10)),
                                Container(
                                    height: 50,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 50),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green),

                                    // Padding(padding: EdgeInsets.all(10)),
                                    child: Container(
                                      child: Text(element.label),
                                    ))
                              ],
                            )
                          ]))
                    ],
                  ),
                ))
            .toList());
  }
}
