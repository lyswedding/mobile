import 'package:flutter/material.dart';

class ListImages extends StatelessWidget {
  const ListImages({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((element) => Container(
                  width: 150,
                  height: 150,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
