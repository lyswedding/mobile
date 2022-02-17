import 'package:flutter/material.dart';

class lists extends StatelessWidget {
  const lists({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height, width;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 800,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => Container(
              height: height,
              width: width,
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.orange),
            ),
          ),
        )
      ],
    ));
  }
}
