import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<Provider> search = [];
  List<Service> services = [];
  List<Provider> foundServices = [];
  List<Provider> foundProviders = [];
  bool isLoaded = false;

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

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    animationController1 = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
    fetchsearch();
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
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Container(
                  //  Transform.translate(
                  // offset: const Offset(10, 0),
                  padding: EdgeInsets.only(top: 10),
                  // margin: EdgeInsets.symmetric(vertical: 5),

                  child: Image.asset(
                    "images/adel.png",
                    height: 60,
                  ),
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
                    _runFilter(text);
                  },
                ),
                //ItemList(text: "text", items: items, width: 150, height: 50),
                _buildCategories(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Results",style: subTitleTextStyle,),
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

        return ItemListSearch(
          isSelected: false,
          provider: search[index],
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
                return CategoryItem(services[index].title, services[index].icon,
                    animationController1, animation, () {
                  _filterByServices(services[index].title);
                }, () {
                  _removeFromSearchResult(services[index].title);
                });
              }),
        ),
      )),
    );
  }

  _filterByServices(text) {
    for (var element in search) {
      element.services.forEach((service) {
        print(service['name']);
        if (service['name'] == text) {
          print(element.name);
          setState(() {
            if (foundServices.contains(element) == false)
              foundServices.add(element);
          });
        }
      });

      foundProviders = foundServices;
      print(foundServices);
      // print(foundUserTaskLists);
    }
  }

  _removeFromSearchResult(text) {
    // List<Provider> foundServices = [];
    search.forEach((provider) {
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
      fetchsearch();
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Provider> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      fetchsearch();
    } else {
      results = search
          .where((provider) => provider.name!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      // taskLists = results;
      foundProviders = results;
    });
  }
}
