import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:lys_wedding/UI/favorite/modele/model_favorite.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/favorite.services.dart';
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
  List<Provider> images = [];

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
  bool closeTopContainer = false;
  double topContainer = 0;
  bool isInCall = false;
  bool isLoaded = false;
  bool isLoading = true;
  bool isSelected = false;
  callGetProviders() async {
    popularProviders = await ServiceList.getPrestataire();

    setState(() {
      isInCall = false;
    });
  }

  _buildListPopular() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: popularProviders
            .map((element) => ItemList(
                  item: element,
                  height: 150.0,
                  width: 250.0,
                ))
            .toList(),
      ),
    );
  }

  getimages() {}
  callAddToFavorite() async {
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

  deleteFromFavorite() async {
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
                                  setState(() {
                                    isSelected = !isSelected;
                                    if (isSelected) {
                                      checkIfTokenExists(() {
                                        callAddToFavorite();
                                      }, context);
                                    } else {
                                      deleteFromFavorite();
                                    }
                                  });
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
                    // Row(
                    //   children: [
                    //     const Icon(
                    //       EvaIcons.pin,
                    //       size: 18,
                    //       color: primaryColor,
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text(
                    //       widget.provider.locations.first.address!,
                    //       // "4140 Parker Rd. Allentown, New Mexico 31134",
                    //       overflow: TextOverflow.ellipsis,
                    //       style: subTitleTextStyle,
                    //     ),
                    //   ],
                    // ),
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
                    // "data  text Jane Cooper data  text Jane Cooper\n 1901 Thornridge Cir. Shiloh, Hawaii data  text Jane Cooper\n Coiffure ,maquillage data  text Jane Cooper "),
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
                    // Expanded(
                    //     child: ListView.builder(
                    //         controller: controller,
                    //         itemCount: itemsData.length,
                    //         physics: BouncingScrollPhysics(),
                    //         itemBuilder: (context, index) {
                    //           double scale = 1.0;
                    //           if (topContainer > 0.5) {
                    //             scale = index + 0.5 - topContainer;
                    //             if (scale < 0) {
                    //               scale = 0;
                    //             } else if (scale > 1) {
                    //               scale = 1;
                    //             }
                    //           }
                    //           return Opacity(
                    //             opacity: scale,
                    //             child: Transform(
                    //               transform: Matrix4.identity()
                    //                 ..scale(scale, scale),
                    //               alignment: Alignment.bottomCenter,
                    //               child: Align(
                    //                   heightFactor: 0.7,
                    //                   alignment: Alignment.topCenter,
                    //                   child: itemsData[index]),
                    //             ),
                    //           );
                    //         })),
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
                    Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemExtent: 35.0,
                          shrinkWrap: true,
                          itemCount: widget.provider.locations.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: (() {
                                _makeSocialMediaRequest(
                                    "https://www.google.com/maps/@34.783145,10.7544576,13z");
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
                                        widget
                                            .provider.locations[index].address!,

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
