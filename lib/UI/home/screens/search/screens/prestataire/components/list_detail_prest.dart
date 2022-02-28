import 'package:flutter/material.dart';

class ItemListPrest extends StatelessWidget {
  const ItemListPrest({
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
