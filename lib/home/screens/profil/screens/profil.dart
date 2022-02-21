import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                            child: Row(children: const [
                              Icon(Icons.person),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('Informations'),
                            ]),
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined),
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
                            child: Row(children: const [
                              Icon(Icons.favorite),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('prestataires'),
                            ]),
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined),
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
                            child: Row(children: const [
                              Icon(Icons.list),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('Listes'),
                            ]),
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined),
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
                            child: Row(children: const [
                              Icon(Icons.settings),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('Paramètres'),
                            ]),
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined),
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
                            child: Row(children: const [
                              Icon(Icons.logout),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('Deconnexion'),
                            ]),
                          ),
                          const Icon(Icons.arrow_forward_ios_outlined),
                        ],
                      )),
                ],
              ),
            )
          ]),
        ));
  }
}
