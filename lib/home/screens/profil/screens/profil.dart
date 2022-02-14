import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/favorite/component/title_pages.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TitlePages(title: "Profil"),
      Image.asset(
        "images/icon.png",
        scale: 3,
      )
    ])));
  }
}
