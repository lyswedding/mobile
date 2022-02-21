import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({
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
      child: Row(
        children: items
            .map((element) => Container(
                  width: width,
                  height: height,
                  child: Column(
                    children: [
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
                      Expanded(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              text,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(element),
                      )),
                ))
            .toList(),
      ),
    );
  }
}
