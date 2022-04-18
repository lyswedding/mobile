import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/item_list.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails>
    with TickerProviderStateMixin {
  bool isInCall = false;
  List<Service> services = [];
  List<Provider> popularProviders = [];
  List<Provider> foundProviders = [];
  List<Provider> foundServices = [];
  List<TaskList> lists = [];

  late AnimationController animationController;
  late AnimationController animationController1;

  callGetServices() async {
    services = await CategorieCalls.getAdminServices();

    setState(() {
      isInCall = false;
    });
  }

  callGetProviders() async {
    popularProviders = await ServiceList.getPrestataire();
    foundProviders=popularProviders;
    setState(() {
      isInCall = false;
    });
  }

  callGetLists() async {
    lists = await ListCalls.getAdminLists();

    setState(() {
      isInCall = false;
    });
  }

  _filterByServices(text) {
    for (var element in popularProviders) {
      element.services.forEach((service) {
        print(service['name']);
        if (service['name'] == text) {
          print(element.name);
          setState(() {
            if(foundServices.contains(element)==false)
              foundServices.add(element);
          });
        }
      });
    }
      foundProviders = foundServices;
    print(foundProviders);
    // print(foundUserTaskLists);
  }
  _removeFromSearchResult(text) {
   // List<Provider> foundServices = [];
    popularProviders.forEach((provider) {
      provider.services.forEach((service) {
        print(service['name']);
        if (service['name'] == text) {
          print(provider.name);
          setState(() {
            foundProviders.remove(provider);
          });
        }
      });
    });
    if (foundProviders.isEmpty) {
      callGetProviders();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    callGetServices();
    callGetProviders();
    callGetLists();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animationController1 = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: GestureDetector(
              onTap: () {
                deleteToken();
              },
              child: Text(
                "Bonjour",
                style: titleTextStyle.copyWith(fontSize: 24),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "images/adel.png",
                  height: 50,
                ),
              ),
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
                          image: AssetImage("images/11.jpg"),
                          fit: BoxFit.fill)),
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
                _buildListPopular(),
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

                _buildListFavorites(),
              ]),
            ),
          )),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
          child: SizedBox(
        height: 80,
        child: ListView.builder(
            itemCount: services.length,
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
              return CategoryItem(services[index].title, services[index].icon,
                  animationController, animation, () {
                _filterByServices(services[index].title);
              }, () {
                _removeFromSearchResult(services[index].title);
              });
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
  //             taskList: ,
  //               animationController: animationController1,
  //               animation: animation);
  //         }),
  //   ));
  // }

  Widget _buildListPopular() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: foundProviders
            .map((element) => ItemList(
                  item: element,
                  height: 150.0,
                  width: 250.0,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildListFavorites() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Row(
          children: lists
              .map(
                (element) => ListComponent(
                  taskList: element,
                  animationController: animationController,
                  animation: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval((1 / 6) * 10, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

}
