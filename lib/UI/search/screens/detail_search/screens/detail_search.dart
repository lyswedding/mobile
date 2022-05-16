import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/UI/favorite/modele/model_favorite.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/related_list.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/search/screens/detail_search/component/list_image.dart';
import 'package:lys_wedding/shared/constants.dart';
import '../../../../../models/List_search.dart';
import '../../../../home/components/shared/item_list.dart';

class DetailSearch extends StatefulWidget {
  DetailSearch({Key? key, required this.provider}) : super(key: key);

  final Provider provider;

  @override
  State<DetailSearch> createState() => _DetailSearchState();
}

class _DetailSearchState extends State<DetailSearch> {
  final Url = "https://www.facebook.com/adel.yakoubi.967";
  List<Provider> popularProviders = [];
  List<Provider> ProvidersRelated = [];
  List<Provider> images = [];
  List<Service> services = [];
  // List images = [
  //   "images/11.jpg",
  //   "images/12.jpg",
  //   "images/3.jpg",
  //   "images/4.jpg",
  //   "images/5.jpg",
  //   "images/6.jpg",
  //   "images/7.jpg",
  //   "images/8.jpg",
  //   "images/8.jpg",
  //   "images/8.jpg"
  // ];
  List<Widget> itemsData = [];
  ScrollController controller = ScrollController();
  List<Provider> foundServices = [];
  List<Provider> foundProviders = [];
  late AnimationController animationController;
  late AnimationController animationController1;
  bool closeTopContainer = false;
  double topContainer = 0;
  bool isInCall = false;
  bool isLoaded = false;
  bool isLoading = true;
  bool isSelected = false;
  var nbraff = 3;
  callGetProviders() async {
    popularProviders = await ServiceList.getPrestataire();

    setState(() {
      isInCall = false;
    });
  }

  callGetRelatedlist() async {
    ProvidersRelated = await RelatedList.getPrestataire(widget.provider.id);

    setState(() {
      isInCall = false;
    });
  }

  _removeFromSearchResult(text) {
    // List<Provider> foundServices = [];
    popularProviders.forEach((provider) {
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
      callGetProviders();
    }
  }

  _filterByServices(text) {
    for (var element in popularProviders) {
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
    }
    foundProviders = foundServices;
    print(foundProviders);
    // print(foundUserTaskLists);
  }

  _buildListPopular() {
    print(ProvidersRelated.toString() + "hhhhhhh");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ProvidersRelated.map((element) => ItemList(
              item: element,
              height: 150.0,
              width: 250.0,
            )).toList(),
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
            itemCount: services.length,
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
              return isLoading
                  ? getShimmerLoading(30, 80)
                  : callGetRelatedlist();
            }),
      )),
    );
  }

  getimages() {}
  callAddToFavorite(String id) async {
    await FavoriteCalls.addProviderToFavorite(widget.provider.id).then((value) {
      print(value.data);
      if (value.statusCode == 201) {
        showToast(context: context, msg: value.data['message'].toString());
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });
    setState(() {
      isInCall = true;
    });
  }

  deleteFromFavorite(String id) async {
    await FavoriteCalls.deletProviderFromFavorite(widget.provider.id)
        .then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        showToast(context: context, msg: value.data['message'].toString());
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });
    setState(() {
      isInCall = true;
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
    callGetProviders();
    callGetRelatedlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.provider.images);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Detail Search",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: isLoading
                ? getShimmerLoadingdetprest()
                : Column(children: [
                    // TItleForPage(),
                    Stack(
                      children: [
                        ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            child: Stack(children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1.3,
                                child: Image.network(
                                  widget.provider.cover,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ])),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withOpacity(1),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(32.0),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   isSelected = !isSelected;
                                  // });
                                  if (isSelected) {
                                    checkIfTokenExists(() {
                                      deleteFromFavorite(widget.provider.id);
                                    }, context)
                                        .then((value) => isSelected = false);
                                  } else {
                                    checkIfTokenExists(() {
                                      callAddToFavorite(widget.provider.id);
                                    }, context)
                                        .then((value) => isSelected = true);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    isSelected
                                        ? EvaIcons.heart
                                        : EvaIcons.heartOutline,
                                    color: const Color(0xffEB5890),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.provider.name,
                          style: titleTextStyle,
                        )),

                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.provider.services[0]['name'].toString(),
                          style: const TextStyle(color: Colors.grey),
                        )),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                  onTap: () async {
                                    final Url = widget.provider.facebookUrl;
                                    if (await canLaunch(Url)) {
                                      await launch(Url,
                                          forceWebView: true,
                                          enableJavaScript: true);
                                    }
                                  },
                                  child: Icon(EvaIcons.facebook)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  final Url = widget.provider.instagramUrl;
                                  if (await canLaunch(Url)) {
                                    await launch(Url,
                                        forceWebView: true,
                                        enableJavaScript: true);
                                  }
                                },
                                child: Image.asset(
                                  "images/insta.png",
                                  scale: 18,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  _makeSocialMediaRequest(
                                      "https://www.google.com/maps/@34.783145,10.7544576,13z");
                                  // // final Url =
                                  // //     "https://www.facebook.com/adel.yakoubi.967";
                                  // if (await canLaunch(Url)) {
                                  //   await launch(Url,
                                  //       forceWebView: true, enableJavaScript: true);
                                  // }
                                },
                                child: Icon(Icons.pin_drop_outlined),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                  onTap: () async {
                                    if (await canLaunch(
                                        'tel:${widget.provider.phone}')) {
                                      await launch(
                                          'tel:${widget.provider.phone}');
                                    } else {
                                      throw 'call not possible';
                                    }
                                  },
                                  child: Icon(EvaIcons.phone)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReadMoreText(
                      widget.provider.description.toString(),
                      trimLines: 2,
                      style: regularTextStyle,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: regularTextStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Photos",
                          style: titleTextStyle,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    ListImages(
                      items: widget.provider.images,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Adresse",
                          style: titleTextStyle,
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Stack(children: [
                      Container(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemExtent: 35.0,
                            shrinkWrap: true,
                            itemCount: widget.provider.locations.length < 3
                                ? widget.provider.locations.length
                                : nbraff,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: (() {
                                  _makeSocialMediaRequest(
                                      "https://www.google.com/maps/place/${widget.provider.locations[index].lat!},${widget.provider.locations[index].long!}");
                                }),
                                child: Card(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        EvaIcons.pin,
                                        size: 18,
                                        color: primaryColor,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.provider.locations[index]
                                              .address!,

                                          // "4140 Parker Rd. Allentown, New Mexico 31134",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,

                                          style: subTitleTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })),
                      ),
                      widget.provider.locations.length > nbraff
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              top: 20,
                              child: Container(
                                height: 10.0,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                      Color.fromARGB(0, 148, 148, 148),
                                      Colors.white
                                    ])),
                              ),
                            )
                          : Positioned(
                              child: Text(""),
                            ),
                      Positioned(
                          bottom: 0,
                          right: 1,
                          left: 150,
                          top: 80,
                          child: InkWell(
                            onTap: () {
                              print("aaaaaaaaaaaaaaa");
                              setState(() {
                                nbraff = widget.provider.locations.length;
                              });
                            },
                            child: widget.provider.locations.length > nbraff
                                ? Text(
                                    "Afficher plus ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                : null,
                          ))
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Prestataire liées",
                          style: titleTextStyle,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildListPopular(),
                  ]),
          ),
        ));
  }
}

Future<void> _makeSocialMediaRequest(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
