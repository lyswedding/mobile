import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  ItemRow(
      {Key? key,
      required this.color,
      required this.title,
      required this.height,
      required this.width,
      required this.images})
      : super(key: key);

  final String title;
  final double height, width;
  final Color color;
  List images = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 0, 0),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(title),
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: height,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  height: height,
                  width: width,
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage(images[index]), fit: BoxFit.fill)),
                ),
              ),
            )
          ],
        )),
      ],
    );
  }
}
