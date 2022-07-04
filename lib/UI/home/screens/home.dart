import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/item_list.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/profil/screens/profil.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({Key? key}) : super(key: key);

  @override
  _HomeDetailsState createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails>
    with TickerProviderStateMixin {
  bool isInCall = true;
  List<Service> services = [];
  List<ServiceProvider> popularProviders = [];
  List<ServiceProvider> foundProviders = [];
  List<ServiceProvider> foundServices = [];
  List<TaskList> lists = [];

  bool isLoaded = false;
  bool isLoading = true;
  UserApi item = UserApi();
  final ServiceProfil service = ServiceProfil();
  late AnimationController animationController;
  late AnimationController animationController1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Provider.of<ListCalls>(context, listen: false).getAdminLists();
    Provider.of<FavoriteCalls>(context, listen: false).getFavorite();
    Provider.of<FavoriteCalls>(context, listen: false).GetProvidersFavorite();
    Provider.of<ProviderCalls>(context, listen: false).getPrestataire();
    Provider.of<CategorieCalls>(context, listen: false).getAdminServices();
    foundProviders =
        Provider.of<ProviderCalls>(context, listen: false).searchLists;
    if (getUserInfoSharedPref("token") != null) {
      Provider.of<ServiceProfil>(context, listen: false).getUser();
    }
    _refreshController.refreshCompleted();
  }

  _filterByServices(text) {
    // foundProviders =
    //     Provider.of<ProviderCalls>(context, listen: false).searchLists;
    for (var element
        in Provider.of<ProviderCalls>(context, listen: false).searchLists) {
      element.services.forEach((service) {
        print(service['name'] + "aaaaaaaaa");
        if (service['name'] == text) {
          print(element.name);
          setState(() {
            if (foundServices.contains(element) == false)
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
    Provider.of<ProviderCalls>(context, listen: false)
        .searchLists
        .forEach((provider) {
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
      foundProviders =
          Provider.of<ProviderCalls>(context, listen: false).searchLists;
    }
  }

  bool? checkIsFavorite(List<String> list, listId) {
    if (list.contains(listId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        isLoading = false;
      });
    });
    Provider.of<ListCalls>(context, listen: false).getAdminLists();
    Provider.of<FavoriteCalls>(context, listen: false).getFavorite();
    Provider.of<FavoriteCalls>(context, listen: false).GetProvidersFavorite();
    Provider.of<ProviderCalls>(context, listen: false).getPrestataire();
    Provider.of<CategorieCalls>(context, listen: false).getAdminServices();
    // TODO: implement initState
    foundProviders =
        Provider.of<ProviderCalls>(context, listen: false).searchLists;
    if (getUserInfoSharedPref("token") != null) {
      Provider.of<ServiceProfil>(context, listen: false).getUser();
    }

    animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animationController1 = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(),
      inAsyncCall: Provider.of<ListCalls>(context, listen: false).isProcessing,
      child: SafeArea(
        top: true,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilPage()));
                      },
                      child: Provider.of<ListCalls>(context, listen: false)
                              .isProcessing!
                          ? getShimmerLoadingcirclehome(
                              35,
                            )
                          : CircleAvatar(
                              radius: 100,
                              backgroundImage: NetworkImage(
                                  Provider.of<ServiceProfil>(context,
                                          listen: false)
                                      .userImageUrl),
                            ))),
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  "Bonjour",
                  style: titleTextStyle.copyWith(
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            body: OfflineBuilder(
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
                      child: Padding(
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
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SingleChildScrollView(
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
                  parent: animationController,
                  curve: const Interval((1 / 6) * 5, 1.0,
                      curve: Curves.fastOutSlowIn),
                ),
              );
              animationController.forward();
              return Provider.of<ListCalls>(context, listen: false)
                      .isProcessing!
                  ? getShimmerLoading(30, 80)
                  : CategoryItem(
                      Provider.of<CategorieCalls>(context, listen: false)
                          .servicesLists[index]
                          .title,
                      Provider.of<CategorieCalls>(context, listen: false)
                          .servicesLists[index]
                          .icon,
                      animationController,
                      animation, () {
                      _filterByServices(
                          Provider.of<CategorieCalls>(context, listen: false)
                              .servicesLists[index]
                              .title);
                    }, () {
                      _removeFromSearchResult(
                          Provider.of<CategorieCalls>(context, listen: false)
                              .servicesLists[index]
                              .title);
                    });
            }),
      )),
    );
  }

  Widget _buildListPopular() {
    return Provider.of<ProviderCalls>(context, listen: false).isProcessing
        ? Container(
            height: MediaQuery.of(context).size.height * 0.2,
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: foundProviders
                  .map((element) => isLoading
                      ? getShimmerLoading(150, 250)
                      : ItemList(
                          item: element,
                          height: 150.0,
                          width: 250.0,
                          isSelected: checkIsFavorite(
                              Provider.of<FavoriteCalls>(context, listen: false)
                                  .favoriteProvidersId,
                              element.id)!,
                        ))
                  .toList(),
            ),
          );
  }

  Widget _buildListFavorites() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.42,
        child: Row(
          children: Provider.of<ListCalls>(context, listen: false)
              .tasksLists
              .map(
                (element) => Provider.of<ListCalls>(context, listen: false)
                        .isProcessing!
                    ? getShimmerLoading(250, 200)
                    : ListComponent(
                        taskList: element,
                        animationController: animationController,
                        animation: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: const Interval((1 / 6) * 10, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        ),
                        isSelected: checkIsFavorite(
                            Provider.of<FavoriteCalls>(context, listen: false)
                                .favoriteListId,
                            element.id)!,
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}
