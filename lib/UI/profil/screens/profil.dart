import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/favorite/screens/favoritePage.dart';
import 'package:lys_wedding/UI/profil/screens/modif_profil.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  UserApi item = UserApi();
  bool isLoaded = false;
  final ServiceProfil service = ServiceProfil();
  Future<void> fetchProfil() async {
    setState(() {
      isLoaded = true;
    });
    item = await service.getUser();
    print(item.user);
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    checkIfTokenExist(() {
      fetchProfil();
    }, context);
    super.initState();
  }

  AccessToken? _accessToken;
  UserFbModel? _currentUser;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall: isLoaded,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: const Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(item.user!.imageUrl ?? ""),
              ),
              Text(
                item.user!.firstName ?? "foulan",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                item.user!.email ?? "",
                style: TextStyle(fontSize: 15),
              ),
              Column(
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilPageModif(
                                          user: item.user!,
                                        ))).then((value) => fetchProfil());
                          },
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
                          ))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavoritePage()));
                            },
                            child: Row(children: const [
                              Icon(Icons.person),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('prestataires'),
                            ]),
                          )),
                          const Icon(Icons.arrow_forward_ios_outlined),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: const [
                              Icon(Icons.list),
                              Padding(padding: EdgeInsets.only(left: 20)),
                              Text('Listes'),
                            ]),
                            const Icon(Icons.arrow_forward_ios_outlined),
                          ],
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      height: 50,
                      width: 800,
                      child: InkWell(
                          onTap: () {
                            googleSignOut();
                            deleteToken();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
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
                          ))),
                ],
              )
            ]),
          )),
    );
  }

  Future<void> SignOut() async {
    await FacebookAuth.i.logOut();
    _currentUser = null;
    _accessToken = null;
    setState(() {});
  }

  googleSignOut() {
    GoogleSingnOutApi.logout();
  }
}
