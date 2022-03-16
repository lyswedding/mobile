import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/shared/constants.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<Provider> search = [];
  List<Service> services = [];
  final List<Provider> foundServices = [];
  bool isLoaded = false;

  late AnimationController animationController;
  late AnimationController animationController1;

  fetchsearch() async {
    search = await ServiceList.getPrestataire();

    setState(() {
      isLoaded = true;
    });
  }

  callGetServices() async {
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(children: [
              SearchBar(
                onchanged: (text){
                  _runFilter(text);
                },
              ),
              //ItemList(text: "text", items: items, width: 150, height: 50),
              _buildCategories(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text("Results"), Text("view more")]),
              ),
              _buildListFavoriteProviders(),
            ]),
          ),
        ));
  }

  Widget _buildListFavoriteProviders() {
    return SingleChildScrollView(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
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
              // items: search!.providers
              //     .map((e) => ListItem(image: e.cover, label: e.name))
              //     .toList()
            );
          }),
    ));
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
                return GestureDetector(
                  onTap: (){
                    _filterByServices(services[index].title);
                  },
                  child: CategoryItem(services[index].title, services[index].icon,
                      animationController1, animation,),
                );
              }),
        ),
      )),
    );
  }

  _filterByServices(text) {
    for (var element in search) {
      element.services.forEach((service) {
        print(service['name']);
        if (service['name']==text) {
          print(element.name);
          setState(() {
            foundServices.add(element);
          });
        }
      });
    }
    search = foundServices;
    print(foundServices);
    // print(foundUserTaskLists);
  }

  void _runFilter(String enteredKeyword) {
    List<Provider> results = [];


    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = search;
    } else {
      results = search
          .where((provider) => provider.name!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      // taskLists = results;
      search = results;
    });
  }

}
