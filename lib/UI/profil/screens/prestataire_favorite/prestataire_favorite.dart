import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/UI/search/servises/service_list.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/shared/constants.dart';

class PrestFav extends StatefulWidget {
  @override
  _PrestFavState createState() => _PrestFavState();
}

class _PrestFavState extends State<PrestFav> with TickerProviderStateMixin {
  List<Provider> search = [];
  bool isLoaded = false;

  final ServiceList service = ServiceList();
  late AnimationController animationController;
  late AnimationController animationController1;

  fetchsearch() async {
    search = await service.getPrestataire();

    setState(() {
      isLoaded = true;
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
          title: const Text(
            "Prestataire favorie",
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

            _buildListFavoriteProviders(),
          ]),
        ));
  }

  Widget _buildListFavoriteProviders() {
    return SingleChildScrollView(
        child: SizedBox(
      height: 700,
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
              text: '', items: [],
              // items: search!.providers
              //     .map((e) => ListItem(image: e.cover, label: e.name))
              //     .toList()
            );
          }),
    ));
  }
}
