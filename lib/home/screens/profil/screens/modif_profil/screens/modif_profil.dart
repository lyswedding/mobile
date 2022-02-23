import 'package:flutter/material.dart';

class ProfilPageModif extends StatefulWidget {
  const ProfilPageModif({Key? key}) : super(key: key);

  @override
  _ProfilPageModifState createState() => _ProfilPageModifState();
}

class _ProfilPageModifState extends State<ProfilPageModif> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Modifier Profile",
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
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "images/adel.png",
                    scale: 3,
                  ),
                  Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: Colors.grey),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.black,
                        ),
                      ))
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                      // padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child:
                          // Container(
                          //   child: Row(children: const [
                          //     Text('Username'),
                          //     Padding(padding: EdgeInsets.only(right: 220)),
                          //     const Icon(Icons.save_outlined),
                          //   ]),
                          // )
                          TextField(
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.save_outlined,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            hintText: "username",
                            hintStyle: TextStyle(
                                fontFamily: "bold", color: Colors.black)),
                      )),
                  Container(
                      // padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            hintText: "Email",
                            hintStyle: TextStyle(
                                fontFamily: "bold", color: Colors.black)),
                      )),
                  Container(
                      // padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "bold", color: Colors.black)),
                      )),
                  Container(
                      // padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                            hintText: "Telephone",
                            hintStyle: TextStyle(
                                fontFamily: "bold", color: Colors.black)),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
