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
                            child: const Icon(
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
                                  const TextStyle(color: Colors.white, fontSize: 15),
                            )),
                      )
                    ],
                  ),
                margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
