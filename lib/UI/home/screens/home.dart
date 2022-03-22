import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/item_list.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/constants.dart';

import '../../../shared/sharedPrefValues.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails>
    with TickerProviderStateMixin {
  List items = [
    "images/10.jpg",
    "images/3.jpg",
    "images/2.jpg",
    "images/4.jpg",
    "images/5.jpg",
    "images/6.jpg",
  ];

  late AnimationController animationController;
  late AnimationController animationController1;
  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animationController1 = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            "Bonjour",
            style: TextStyle(color: Colors.black),
          ),
          leading: Container(
            //  Transform.translate(
            // offset: const Offset(10, 0),
            padding: EdgeInsets.only(top: 10),
            // margin: EdgeInsets.symmetric(vertical: 5),

            child: Image.asset(
              "images/adel.png",
              height: 50,
            ),
          ),
          actions: <Widget>[
            Icon(
              Icons.search,
              color: Colors.black,
              size: 24,
            ),
            Padding(padding: EdgeInsets.all(10)),
            InkWell(
                child: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 24,
                ),
                onTap: () {
                  GoogleSingnOutApi.logout().then((value) {
                    deleteToken();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                }),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              // TItleForPage(),
              Container(
                height: 150,
                padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                // margin: const EdgeInsets.fromLTRB(30, 30, 10, 0),
                child: Center(
                  child: Text(
                    "We are here to help you planning your wedding",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage("images/11.jpg"), fit: BoxFit.fill)),
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Categorie",
                    style: titleTextStyle,
                  )),
              _buildCategories(),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Bon plan",
                    style: titleTextStyle,
                  )),
              const SizedBox(
                height: 16,
              ),
              ItemList(
                text:
                    "Jane Cooper\n 1901 Thornridge Cir. Shiloh, Hawaii\n Coiffure ,maquillage  ",
                items: items,
                height: 150.0,
                width: 250.0,
              ),
              const SizedBox(
                height: 16,
              ),

              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Listes populaires",
                    style: titleTextStyle,
                  )),
              const SizedBox(
                height: 10,
              ),

              // _buildListFavoriteLists(),
            ]),
          ),
        ));
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
          child: SizedBox(
        height: 80,
        child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: const Interval((1 / 6) * 5, 1.0,
                      curve: Curves.fastOutSlowIn),
                ),
              );
              animationController.forward();
              return CategoryItem(
                  'text', 'images/9.jpg', animationController, animation);
            }),
      )),
    );
  }

  // Widget _buildListFavoriteLists() {
  //   return SingleChildScrollView(
  //       child: SizedBox(
  //     height: 400,
  //     child: GridView.builder(
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             // crossAxisSpacing: 5,
  //             // mainAxisSpacing: 5,
  //             childAspectRatio: 0.6),
  //         itemCount: 10,
  //         scrollDirection: Axis.vertical,
  //         itemBuilder: (context, index) {
  //           var animation = Tween(begin: 0.0, end: 1.0).animate(
  //             CurvedAnimation(
  //               parent: animationController1,
  //               curve: const Interval((1 / 6) * 5, 1.0,
  //                   curve: Curves.fastOutSlowIn),
  //             ),
  //           );
  //           animationController1.forward();
  //           return ListComponent(
  //             taskList: TaskList(id, title, description, tasks, tags, imageUrl),
  //               animationController: animationController1,
  //               animation: animation);
  //         }),
  //   ));
  // }
  googleSignOut() {
    GoogleSingnOutApi.logout();
  }
}
