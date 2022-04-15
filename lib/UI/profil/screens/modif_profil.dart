import 'package:flutter/material.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/services/profil_service.dart';


class ProfilPageModif extends StatefulWidget {
  const ProfilPageModif({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _ProfilPageModifState createState() => _ProfilPageModifState();
}

class _ProfilPageModifState extends State<ProfilPageModif> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  var isclickedtoedit = true;
  var isclickedtoedit1 = true;
  var isclickedtoedit2 = true;
  var isclickedtoedit3 = true;
  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user.firstName!;
    _emailController.text = widget.user.email!;
    _PasswordController.text = widget.user.password!;
    _phoneController.text = widget.user.phone!;
  }

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
              // Stack(
              //   children: [
              //     // CircleAvatar(
              //     //   radius: 100,
              //     //   backgroundImage:
              //     //       NetworkImage(widget.user.imageUrl as String),
              //     // ),
              //     Positioned(
              //         bottom: 12,
              //         right: 12,
              //         child: InkWell(
              //             onTap: (() {}),
              //             child: Container(
              //               height: 40,
              //               width: 40,
              //               decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   border: Border.all(
              //                       width: 4,
              //                       color: Theme.of(context)
              //                           .scaffoldBackgroundColor),
              //                   color: Colors.grey),
              //               child: Icon(
              //                 Icons.camera_alt_rounded,
              //                 color: Colors.black,
              //               ),
              //             )))
              //   ],
              // ),
              Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    height: 50,
                    width: 800,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          controller: _firstNameController,
                          onChanged: (value) {
                            widget.user.firstName = value;
                            print(widget.user.firstName);
                          },
                          enabled: !isclickedtoedit,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              // hintText: widget.user.firstName,
                              hintStyle: TextStyle(
                                  fontFamily: "bold", color: Colors.black)),
                        ),
                        isclickedtoedit
                            ? IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit = !isclickedtoedit;
                                  });
                                  // ServiceProfilModif.updateUser(
                                  //     widget.user.firstName!,
                                  //     _firstNameController.text);
                                })
                            : IconButton(
                                icon: Icon(Icons.save),
                                onPressed: ()async {
                                  setState(() {
                                    isclickedtoedit = !isclickedtoedit;
                                  });

                                  await ServiceProfil.updateUser(
                                     "firstName",
                                      _firstNameController.text).then((value) => print(value));
                                }),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    height: 50,
                    width: 800,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          enabled: isclickedtoedit1,
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.user.email,
                              hintStyle: const TextStyle(
                                  fontFamily: "bold", color: Colors.black)),
                        ),
                        isclickedtoedit1
                            ? IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit1 = !isclickedtoedit1;
                                  });
                                  ServiceProfil.updateUser(
                                      widget.user.email!,
                                      _emailController.text);
                                })
                            : IconButton(
                                icon: Icon(Icons.save),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit1 = !isclickedtoedit1;
                                  });
                                  ServiceProfil.updateUser(
                                      widget.user.email!,
                                      _emailController.text);
                                }),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    height: 50,
                    width: 800,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          obscureText: true,
                          enabled: !isclickedtoedit2,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "password",
                              hintStyle: TextStyle(
                                  fontFamily: "bold", color: Colors.black)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("change password"),
                                      content: Container(
                                        color: Colors.white,
                                        width: 10.0,
                                        height: 150.0,
                                        child: Column(
                                          children: [
                                            TextField(
                                              decoration: InputDecoration(
                                                  hintText: "Old password",
                                                  hintStyle: TextStyle(
                                                      fontFamily: "bold",
                                                      color: Colors.grey)),
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                  hintText: "New password",
                                                  hintStyle: TextStyle(
                                                      fontFamily: "bold",
                                                      color: Colors.grey)),
                                            ),
                                            Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.black,
                                                  ),
                                                  child: Text("change"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    // ServiceProfilModif
                                                    //     .updateUser(
                                                    //         widget
                                                    //             .user.password!,
                                                    //         _PasswordController
                                                    //             .text);
                                                  },
                                                ))
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    height: 50,
                    width: 800,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          enabled: !isclickedtoedit3,
                          controller: _phoneController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: const TextStyle(
                                  fontFamily: "bold", color: Colors.black)),
                        ),
                        isclickedtoedit3
                            ? IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit3 = !isclickedtoedit3;
                                  });
                                  ServiceProfil.updateUser(
                                      widget.user.phone!,
                                      _phoneController.text);
                                })
                            : IconButton(
                                icon: Icon(Icons.save),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit3 = !isclickedtoedit3;
                                  });
                                  ServiceProfil.updateUser(
                                      widget.user.phone!,
                                      _phoneController.text);
                                }),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
