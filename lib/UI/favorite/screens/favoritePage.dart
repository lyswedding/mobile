import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/shared/constants.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with TickerProviderStateMixin {
  String valuechoose = 'prestataire';
  late AnimationController animationController;
  late TabController _nestedTabController;

  var Listitems = [
    "prestataire",
    "aaaa",
    "bbbb",
    "cccc",
  ];

  List items = [
    "images/4.jpg",
    "images/3.jpg",
    "images/2.jpg",
    "images/4.jpg",
    "images/5.jpg",
    "images/6.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _nestedTabController = new TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Favorite",
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
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TabBar(
              controller: _nestedTabController,
              indicatorColor: Colors.teal,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.black54,
              isScrollable: true,
              tabs: const <Widget>[
                Tab(
                  text: "Listes",
                ),
                Tab(
                  text: "Prestataires",
                ),
              ],
            ),
            SizedBox(
              height: screenHeight,
              child: TabBarView(
                  controller: _nestedTabController,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildListFavoriteLists(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildListFavoriteProviders(),
                    ),
                  ]),
            ),
          ]),
        )));
  }

  Widget _buildListFavoriteLists() {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 800,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 5,
                  // mainAxisSpacing: 5,
                  childAspectRatio: 0.6),
              itemCount: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: const Interval((1 / 6) * 5, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                animationController.forward();
                return ListComponent(
                    animationController: animationController,
                    animation: animation);
              }),
        )
      ],
    ));
  }

  Widget _buildListFavoriteProviders() {
    return SingleChildScrollView(
        child: SizedBox(
      height: 800,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval((1 / 6) * 5, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            );
            animationController.forward();
            return ItemListSearch(
              text: 'text',
              items: items,
              animation: animation,
              animationController: animationController,
            );
          }),
    ));
  }
}
