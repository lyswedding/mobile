import 'package:flutter/material.dart';

class Listprofil extends StatelessWidget {
  const Listprofil(
      {Key? key,
      required this.height,
      required this.width,
      required this.title,
      required this.icon})
      : super(key: key);
  final String title;
  final icon;
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Card(
          child: Column(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.orange),
              height: 50,
              width: 800,
              child: Row(
                children: [
                  Icon(icon),
                  Text(title),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              )),
        ],
      ))
    ]));
  }
}
