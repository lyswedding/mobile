import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/buttom-navigation-bar.dart';

class TitlePages extends StatelessWidget {
  const TitlePages({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const Padding(
        padding: EdgeInsets.fromLTRB(40, 30, 0, 0),
      ),
      Container(
          child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              }),
          const Padding(
            padding: EdgeInsets.only(left: 90),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 40),
          ),
        ],
      ))
    ]);
  }
}
