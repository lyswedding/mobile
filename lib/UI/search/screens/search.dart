import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
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
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  List<ServiceProvider> search = [];
  List<Service> services = [];
  List<ServiceProvider> foundServices = [];
  List<ServiceProvider> foundProviders = [];
  List<ServiceProvider> filtredbyservice = [];

  String textSearch = "";
  bool isLoaded = false;
  bool isLoading = true;

  UserApi item = UserApi();
  final ServiceProfil service = ServiceProfil();
  var animationController;
  var animationController1;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    foundProviders =
        Provider.of<ProviderCalls>(context, listen: false).searchLists;
    Provider.of<ProviderCalls>(context, listen: false).getPrestataire();
    Provider.of<ProviderCalls>(context, listen: false).getFavoritePrestataire(
        Provider.of<ServiceProfil>(context, listen: false).user.user!.id!);
    Provider.of<ServiceProfil>(context, listen: false).getUser();

    _refreshController.refreshCompleted();
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
      Provider.of<ServiceProfil>(context, listen: false).getUser();
    }
    foundProviders =
        Provider.of<ProviderCalls>(context, listen: false).searchLists;
  }

  bool? checkIsFavorite(List<String> list, listId) {
    if (list.contains(listId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(),
      inAsyncCall:
          Provider.of<ProviderCalls>(context, listen: false).isProcessing,
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
                child: Provider.of<ProviderCalls>(context, listen: false)
                        .isProcessing
                    ? getShimmerLoadingcircle(
                        18,
                      )
                    : InkWell(
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              Provider.of<ServiceProfil>(context, listen: false)
                                  .userImageUrl),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilPage()));
                        },
                      ),
              ),
            ],
          ),
          body:
          OfflineBuilder(
            connectivityBuilder: (
                BuildContext context,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  connected
                      ? SmartRefresher(
                    onRefresh: _onRefresh,
                    controller: _refreshController,
                    child: SingleChildScrollView(
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
                    ),
                  )
                      : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.wifiOff,size: 70,),
                        Text(
                          'Turn on your internet connection',
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'There are no bottons to push :)',
                ),
                Text(
                  'Just turn off your internet.',
                ),
              ],
            ),
          ),


          ),
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

            return Provider.of<ProviderCalls>(context, listen: false)
                    .isProcessing
                ? getShimmerLoading(250, 200)
                : ItemListSearch(
                    provider: foundProviders[index],
                    animation: animation,
                    animationController: animationController,
                    text: '',
                    isSelected: checkIsFavorite(
                        Provider.of<FavoriteCalls>(context, listen: false)
                            .favoriteProvidersId,
                        foundProviders[index].id)!,
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
              itemCount: Provider.of<CategorieCalls>(context, listen: false)
                  .servicesLists
                  .length,
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
                    : CategoryItem(
                        Provider.of<CategorieCalls>(context, listen: false)
                            .servicesLists[index]
                            .title,
                        Provider.of<CategorieCalls>(context, listen: false)
                            .servicesLists[index]
                            .icon,
                        animationController1,
                        animation, () {
                        _runFilter(
                            Provider.of<CategorieCalls>(context, listen: false)
                                .servicesLists[index]
                                .title);
                      }, () {
                        _runFilter(null);
                      });
              }),
        ),
      )),
    );
  }

  void _runFilter(String? text) {
    print(text);
    List<ServiceProvider> results = [];

    if (textSearch.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users

      results = List.from(
          Provider.of<ProviderCalls>(context, listen: false).searchLists);
    } else {
      results = foundProviders
          .where((provider) =>
              provider.name.toLowerCase().contains(textSearch.toLowerCase()))
          .toList();
    }
    if (text != null) {
      results = results
          .where((element) => element.services
              .where((s) =>
                  s['name'].toString().toLowerCase() == text.toLowerCase())
              .isNotEmpty)
          .toList();
      // results.forEach((elem) => elem.services.forEach((s) => print(s['name'])));
      print(results);
    } else {
      // results = List.from(
      //     Provider.of<ProviderCalls>(context, listen: false).searchLists);
    }
    setState(() {
      foundProviders = results;
    });
  }
}
