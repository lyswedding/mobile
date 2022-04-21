import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';

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
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  var isclickedtoedit = true;
  var isclickedtoedit1 = true;
  var isclickedtoedit2 = true;
  var isclickedtoedit3 = true;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user.firstName!;
    _emailController.text = widget.user.email!;
    _PasswordController.text = widget.user.password!;
    _phoneController.text = widget.user.phone!;
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100,
              backgroundImage: FileImage(File(_imageFile!.path)),
            ),
            //Image.file(File(_imageFile!.path),height: 200,),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await ServiceProfil.uploadImage(
                        _imageFile!.path, widget.user.id)
                    .then((value) => Navigator.of(context).pop());
              },
              child: const Text('Upload'),
            )
          ],
        ),
      );
    } else {
      return Stack(
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(widget.user.imageUrl as String),
          ),
          Positioned(
              bottom: 12,
              right: 12,
              child: InkWell(
                onTap: (() {
                  _pickImage();
                }),
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        color: Colors.grey),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.black,
                    )),
              ))
        ],
      );
    }
  }

  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception!.code.toString());
    }
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
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
              _previewImage(),
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
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit = !isclickedtoedit;
                                  });
                                })
                            : IconButton(
                                icon: const Icon(Icons.save),
                                onPressed: () async {
                                  setState(() {
                                    isclickedtoedit = !isclickedtoedit;
                                  });

                                  await ServiceProfil.updateUser("firstName",
                                          _firstNameController.text)
                                      .then(
                                    (value) => showToast(
                                        context: context,
                                        msg: value['message']),
                                  );
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
                          enabled: !isclickedtoedit1,
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: widget.user.email,
                              hintStyle: const TextStyle(
                                  fontFamily: "bold", color: Colors.black)),
                        ),
                        isclickedtoedit1
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit1 = !isclickedtoedit1;
                                  });
                                })
                            : IconButton(
                                icon: const Icon(Icons.save),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit1 = !isclickedtoedit1;
                                  });
                                  ServiceProfil.updateUser(
                                          "email", _emailController.text)
                                      .then(
                                    (value) => showToast(
                                        context: context,
                                        msg: value['message']),
                                  );
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
                          decoration: const InputDecoration(
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
                                      title: const Text("change password"),
                                      content: Container(
                                        color: Colors.white,
                                        width: 10.0,
                                        height: 150.0,
                                        child: Column(
                                          children: [
                                            TextField(
                                              decoration: const InputDecoration(
                                                  hintText: "Old password",
                                                  hintStyle: TextStyle(
                                                      fontFamily: "bold",
                                                      color: Colors.grey)),
                                              controller:
                                                  _oldPasswordController,
                                            ),
                                            TextField(
                                              decoration: const InputDecoration(
                                                  hintText: "New password",
                                                  hintStyle: TextStyle(
                                                      fontFamily: "bold",
                                                      color: Colors.grey)),
                                              controller:
                                                  _newPasswordController,
                                            ),
                                            Container(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.black,
                                                  ),
                                                  child: const Text("change"),
                                                  onPressed: () {
                                                    var body = {
                                                      "oldPassword":
                                                          _oldPasswordController
                                                              .text,
                                                      "password":
                                                          _newPasswordController
                                                              .text
                                                    };
                                                    Navigator.pop(context);
                                                    if (_oldPasswordController
                                                            .text.isEmpty ||
                                                        _newPasswordController
                                                            .text.isEmpty) {
                                                      showToast(
                                                          context: context,
                                                          msg:
                                                              'Merci de remplir tous les champs !');
                                                    } else {
                                                      ServiceProfil
                                                          .updateUserPassword(
                                                              body);
                                                    }
                                                    ;
                                                  },
                                                ))
                                          ],
                                        ),
                                      ),
                                    )).then(
                              (value) => showToast(
                                  context: context,
                                  msg: 'Utilisateur mis à jour'),
                            );
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
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontFamily: "bold", color: Colors.black)),
                        ),
                        isclickedtoedit3
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit3 = !isclickedtoedit3;
                                  });
                                })
                            : IconButton(
                                icon: const Icon(Icons.save),
                                onPressed: () {
                                  setState(() {
                                    isclickedtoedit3 = !isclickedtoedit3;
                                  });
                                  ServiceProfil.updateUser(
                                          "phone", _phoneController.text)
                                      .then(
                                    (value) => showToast(
                                        context: context,
                                        msg: value['message']),
                                  );
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
