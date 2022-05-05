import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/home/screens/buttom-navigation-bar.dart';
import 'package:lys_wedding/UI/profil/screens/profil.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';

import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<Provider> search = [];
  List<Service> services = [];
  List<Provider> foundServices = [];
  List<Provider> foundProviders = [];
  List<Provider> filtredbyservice = [];
  String textSearch = "";
  bool isLoaded = false;
  bool isLoading = true;

  UserApi item = UserApi();
  final ServiceProfil service = ServiceProfil();
  var animationController;
  var animationController1;

  fetchsearch() async {
    setState(() {
      isLoaded = true;
    });
    search = await ServiceList.getPrestataire();
    foundProviders = search;
    setState(() {
      isLoaded = false;
    });
  }

  callGetServices() async {
    setState(() {
      isLoaded = true;
    });
    services = await CategorieCalls.getAdminServices();

    setState(() {
      isLoaded = false;
    });
  }

  String imageurl = "https://cdn-icons-png.flaticon.com/512/147/147144.png";
  Future<void> fetchProfil() async {
    setState(() {
      isLoaded = true;
    });

    item = await service.getUser();
    imageurl = item.user!.imageUrl!;
    print(item.user);
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        isLoading = false;
      });
    });
    // TODO: implement initState
    animationController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    animationController1 = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
    super.initState();
    if (getUserInfoSharedPref("token") != null) {
      fetchProfil();
    }
    callGetServices();
    print(search);
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(),
      inAsyncCall: isLoaded,
      child: Scaffold(
          backgroundColor: scaffoldBGColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              "Search",
              style: titleTextStyle.copyWith(fontSize: 20),
            ),
            actions: [
              // margin: EdgeInsets.symmetric(vertical: 5),

              Padding(
                padding: const EdgeInsets.only(
                  right: 18.0,
                ),
                child: IconButton(
                  icon: Image(
                    image: NetworkImage(imageurl),
                    height: 50,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilPage()));
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBar(
                      onchanged: (text) {
                        textSearch = text;
                        _runFilter(null);
                      },
                    ),
                    //ItemList(text: "text", items: items, width: 150, height: 50),
                    _buildCategories(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Results",
                        style: subTitleTextStyle,
                      ),
                    ),
                    _buildListFavoriteProviders(),
                  ]),
            ),
          )),
    );
  }

  Widget _buildListFavoriteProviders() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: foundProviders.length,
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
                    provider: foundProviders[index],
                    animation: animation,
                    animationController: animationController,
                    text: '',
                  );
          }),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: services.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController1,
                    curve: const Interval((1 / 6) * 5, 1.0,
                        curve: Curves.fastOutSlowIn),
                  ),
                );
                animationController1.forward();
                return isLoading
                    ? getShimmerLoading(30, 80)
                    : CategoryItem(services[index].title, services[index].icon,
                        animationController1, animation, () {
                        _runFilter(services[index].title);
                      }, () {
                        _runFilter(null);
                      });
              }),
        ),
      )),
    );
  }

  void _runFilter(String? text) {
    List<Provider> results = [];
    print(textSearch);
    if (textSearch.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      fetchsearch();
    } else {
      results = search
          .where((provider) =>
              provider.name.toLowerCase().contains(textSearch.toLowerCase()))
          .toList();
    }
    if (text != null) {
      results = results
          .where((element) =>
              element.services.where((s) => s['name'] == text).isNotEmpty)
          .toList();
    } else {}
    setState(() {
      foundProviders = results;
    });
  }
}
