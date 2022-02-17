import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/favorite/components/title_pages.dart';

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
        const TitlePages(title: "User Profil"),
        Image.asset(
          "images/icon.png",
          scale: 3,
        ),
        const Text(
          "UserName",
          style: TextStyle(fontSize: 25),
        ),
        const Text(
          "UserName@gmail.com",
          style: TextStyle(fontSize: 15),
        ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          Icon(Icons.person),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Informations'),
                        ]),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange),
                  height: 50,
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          Icon(Icons.favorite),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('prestataires'),
                        ]),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange),
                  height: 50,
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          Icon(Icons.list),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Listes'),
                        ]),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange),
                  height: 50,
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          Icon(Icons.settings),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Paramètres'),
                        ]),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.orange),
                  height: 50,
                  width: 800,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          Icon(Icons.logout),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text('Deconnexion'),
                        ]),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  )),
            ],
          ),
        )
      ]),
    ));
  }
}
