import 'package:flutter/material.dart';
import 'package:lys_wedding/home/component/shared/item_row.dart';
import 'package:lys_wedding/home/component/shared/title_for_pagrs.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: const [
        TItleForPage(),
        ItemRow(
          height: 100,
          color: Colors.orange,
          width: 60,
          title: "Categories",
        ),
        ItemRow(
          color: Colors.orange,
          height: 180,
          width: 250,
          title: "Bon Plans",
        ),
        ItemRow(
          color: Colors.orange,
          height: 180,
          width: 180,
          title: "Popular Lists",
        ),
      ]),
    );
  }
}
