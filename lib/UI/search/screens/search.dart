import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/shared/constants.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List items = [
    "images/4.jpg",
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
        duration: Duration(milliseconds: 2000), vsync: this);
    animationController1 = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Search",
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
            const SearchBar(),
            //ItemList(text: "text", items: items, width: 150, height: 50),
            _buildCategories(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                Text("Results"),
                Text("view more")
              ]),
            ),
            _buildListFavoriteProviders(),

          ]),
        ));
  }

  Widget _buildListFavoriteProviders(){
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
                    curve: const Interval((1 / 6) *5, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                animationController.forward();
                return ItemListSearch(text: 'Jane Cooper', items: items,animation: animation,animationController: animationController,);
              }

          ),
        ));
  }

  Widget _buildCategories(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var animation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animationController1,
                        curve: const Interval((1 / 6) *5, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController1.forward();
                    return CategoryItem('text','images/9.jpg',animationController1,animation);
                  }

              ),
            ),
          )),
    );
  }



}
