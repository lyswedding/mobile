import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/favorite/screens/favoritePage.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/UI/profil/screens/modif_profil.dart';
import 'package:lys_wedding/UI/profil/screens/user_lists.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  UserApi item = UserApi();
  bool isLoaded = false;
  bool isInCall = true;
  bool isLoading = true;
  final ServiceProfil service = ServiceProfil();
  List<TaskList> userTaskLists = [];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Provider.of<ServiceProfil>(context, listen: false).getUser();
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        isLoading = false;
      });
    });
    checkIfTokenExist(() {
      Provider.of<ServiceProfil>(context, listen: false).getUser();
    }, context);
    super.initState();
  }

  AccessToken? _accessToken;
  UserFbModel? _currentUser;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: ModalProgressHUD(
        inAsyncCall:
            isLoading,
        progressIndicator: const CircularProgressIndicator(),
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
            body:
            OfflineBuilder(
              connectivityBuilder: (
                  BuildContext context,
                  ConnectivityResult connectivity,
                  Widget child,
                  ) {
                final bool connected = connectivity != ConnectivityResult.none;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    connected
                        ? SingleChildScrollView(
                      child: Column(children: [
                        isLoading
                            ? getShimmerLoadingcirclehome(
                          100,
                        )
                            : CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                              Provider.of<ServiceProfil>(context, listen: false)
                                  .userImageUrl),
                        ),
                        Text(
                          Provider.of<ServiceProfil>(context, listen: false)
                              .user
                              .user!
                              .firstName ??
                              "foulan",
                          style: const TextStyle(fontSize: 25),
                        ),
                        Text(
                          Provider.of<ServiceProfil>(context, listen: false)
                              .user
                              .user!
                              .email ??
                              "",
                          style: const TextStyle(fontSize: 15),
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
                                                user: Provider.of<ServiceProfil>(
                                                    context,
                                                    listen: false)
                                                    .user
                                                    .user!,
                                              ))).then((value) =>
                                          Provider.of<ServiceProfil>(context,
                                              listen: false)
                                              .getUser());
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
                            InkWell(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const FavoritePage()));
                              }),
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),
                                  height: 50,
                                  width: 800,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Row(children: const [
                                            Icon(Icons.favorite_border),
                                            Padding(padding: EdgeInsets.only(left: 20)),
                                            Text('Mes favoris'),
                                          ])),
                                      const Icon(Icons.arrow_forward_ios_outlined),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: (() {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => UserListPage(
                                //               tasksLists: userTaskLists,
                                //             ))).then((value) => callAllUserListes());
                              }),
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),
                                  height: 50,
                                  width: 800,
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
                                  )),
                            ),
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
                                      showAlertDialog(context);
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
                    )
                        : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(EvaIcons.wifiOff,size: 70,),
                          Text(
                            'Turn on your internet connection',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'There are no bottons to push :)',
                  ),
                  Text(
                    'Just turn off your internet.',
                  ),
                ],
              ),
            ),


            ),
      ),
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        googleSignOut();
        deleteToken();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const Home()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text(
          "Voulez vous déconnectez !!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
