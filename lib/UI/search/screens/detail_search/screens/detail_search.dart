import 'package:lys_wedding/UI/favorite/modele/model_favorite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/search/screens/detail_search/component/list_image.dart';

import 'package:lys_wedding/shared/constants.dart';

import '../../../../../models/List_search.dart';
import '../../../../home/components/shared/item_list.dart';

class DetailSearch extends StatelessWidget {
  DetailSearch({Key? key, required this.provider}) : super(key: key);

  final Provider provider;
  final Url = "https://www.facebook.com/adel.yakoubi.967";
  List images = [
    "images/1.jpg",
    "images/2.jpg",
    "images/3.jpg",
    "images/4.jpg",
    "images/5.jpg",
    "images/6.jpg",
    "images/7.jpg",
    "images/8.jpg",
    "images/8.jpg",
    "images/8.jpg"
  ];
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    print(provider.phone);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Detail Search",
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(children: [
              // TItleForPage(),
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.7,
                      child: Image.network(
                        provider.cover,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ])),
              const SizedBox(
                height: 16,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    provider.name,
                    style: titleTextStyle,
                  )),
              Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    size: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    provider.email,
                    // "4140 Parker Rd. Allentown, New Mexico 31134",
                    overflow: TextOverflow.ellipsis,
                    style: subTitleTextStyle,
                  ),
                ],
              ),
              const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "marriage,decoration..",
                    style: TextStyle(color: Colors.grey),
                  )),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final Url = provider.facebookUrl;
                          if (await canLaunch(Url)) {
                            await launch(Url,
                                forceWebView: true, enableJavaScript: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Image(
                          image: AssetImage("images/17.png"),
                        )),
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final Url = provider.instagramUrl;
                          if (await canLaunch(Url)) {
                            await launch(Url,
                                forceWebView: true, enableJavaScript: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Image(
                          image: AssetImage("images/18.png"),
                        )),
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          _makeSocialMediaRequest("http://pratikbutani.com");
                          // // final Url =
                          // //     "https://www.facebook.com/adel.yakoubi.967";
                          // if (await canLaunch(Url)) {
                          //   await launch(Url,
                          //       forceWebView: true, enableJavaScript: true);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Image(
                          image: AssetImage("images/19.png"),
                        )),
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          final Url = "+216" + provider.phone;
                          if (await canLaunch(Url)) {
                            await launch(Url,
                                forceWebView: true, enableJavaScript: true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Image(
                          image: AssetImage("images/20.png"),
                        )),
                  ),
                ],
              ),
              Text(provider.description),
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
                items: images,
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

              // ItemList(
              //   text:
              //       "Jane Cooper\n 1901 Thornridge Cir. Shiloh, Hawaii\n Coiffure ,maquillage  ",
              //   items: images,
              //   height: 150.0,
              //   width: 250.0,
              // ),
              // _buildListFavoriteLists(),
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
