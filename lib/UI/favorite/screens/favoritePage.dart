import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/favorite/service/favorite_service.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';

import '../../../models/List_search.dart';

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
  bool isInCall = false;
  bool isLoaded = false;
  final ServiceFavorite service = ServiceFavorite();
  List<Provider> search = [];
  List<TaskList> taskLists = [];

  callAllListes() {
    setState(() {
      isInCall = true;
    });
     FavoriteCalls.GetTaskListFavorite().then((res) {
      setState(() {
        taskLists = res;
      });
    });
    setState(() {
      isInCall = false;
    });
  }

  fetchsearch() async {
    search = await FavoriteCalls.GetProvidersFavorite();

    setState(() {
      isLoaded = true;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    callAllListes();
    fetchsearch();
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
              itemCount: taskLists.length,
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
                    taskList: taskLists[index],
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
          itemCount: search.length,
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
              provider: search[index],
              animation: animation,
              animationController: animationController,
              text: '',
              //     .map((e) => ListItem(image: e.cover, label: e.name))
              //     .toList()
            );
          }),
    ));
  }
}
