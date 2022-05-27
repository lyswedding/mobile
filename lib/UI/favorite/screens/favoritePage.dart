import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/favorite/service/favorite_service.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/profil/screens/profil.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';

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
  bool isLoading = true;
  final ServiceFavorite service = ServiceFavorite();
  List<Provider> search = [];
  List<TaskList> taskLists = [];
  UserApi item = UserApi();
  final ServiceProfil servicee = ServiceProfil();
  callAllListes() async {
    taskLists = await FavoriteCalls.getFavorite();

    setState(() {
      isLoaded = true;
    });
  }

  fetchsearch() async {
    search = await FavoriteCalls.GetProvidersFavorite();
    print("*****************");
    print(search);
    print("*****************");
    setState(() {
      isLoaded = true;
    });
  }

  String imageurl = "https://cdn-icons-png.flaticon.com/512/147/147144.png";
  Future<void> fetchProfil() async {
    setState(() {
      isLoaded = true;
    });

    item = await servicee.getUser();
    imageurl = item.user!.imageUrl!;
    print(item.user);
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    callAllListes();
    fetchsearch();

    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        isLoading = false;
      });
    });

    if (getUserInfoSharedPref("token") != null) {
      fetchProfil();
    }
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(
                  right: 18.0,
                ),
                child: isLoading
                    ? getShimmerLoadingcircle(
                        18,
                      )
                    : InkWell(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(imageurl),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilPage()));
                        },
                      ))
          ],
        ),
        body: SingleChildScrollView(
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
            child:
                TabBarView(controller: _nestedTabController, children: <Widget>[
              _buildListFavoriteLists(),
              _buildListFavoriteProviders(),
            ]),
          ),
        ])));
  }

  Widget _buildListFavoriteLists() {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
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
                return isLoading
                    ? getShimmerLoading(250, 200)
                    : ListComponent(
                        isSelected: true,
                        taskList: taskLists[index],
                        animationController: animationController,
                        animation: animation,
                      );
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

            return isLoading
                ? getShimmerLoading(250, 200)
                : ItemListSearch(
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
