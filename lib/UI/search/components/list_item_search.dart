import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/common_card.dart';
import 'package:lys_wedding/UI/liste/screens/list_tasks.dart';
import 'package:lys_wedding/UI/liste/screens/task_update.dart';
import 'package:lys_wedding/UI/search/screens/detail_search/screens/detail_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';

import '../../liste/screens/list_details.dart';

class ItemListSearch<T> extends StatefulWidget {
  const ItemListSearch({
    Key? key,
    required this.provider,
    required this.text,
    required this.animation,
    required this.animationController,
  }) : super(key: key);
  final Provider provider;
  final String text;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  State<ItemListSearch<T>> createState() => _ItemListSearchState<T>();
}

class _ItemListSearchState<T> extends State<ItemListSearch<T>> {
  bool isInCall = false;
  bool isSelected = false;
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
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: widget.animation,
      animationController: widget.animationController,
      child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: 350,
              child: CommonCard(
                color: whiteColor,
                radius: 10,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: Stack(
                    children: <Widget>[
                      Column(children: <Widget>[
                        //ProfilePicture(restaurantId: hotelData.id,),
                        AspectRatio(
                            aspectRatio: 2,
                            child: Image.network(
                              widget.provider.cover,
                              fit: BoxFit.cover,
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    widget.provider.name,
                                    textAlign: TextAlign.left,
                                    style: titleTextStyle,
                                  ),
                                ),
                                Text(
                                  '250 visites',
                                  style: regularTextStyle,
                                )
                              ],
                            ),
                            Text(
                              widget.provider.services[0]['name'],
                              style: subTitleTextStyle,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.pin_drop,
                                  size: 12,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Text(
                                  widget.provider.locations[0].address!,
                                  overflow: TextOverflow.ellipsis,
                                  style: subTitleTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
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
                                    checkIfTokenExists((){
                                      callAddToFavorite();
                                    }, context);
                                  } else {
                                    deleteFromFavorite();
                                  }
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  isSelected
                                      ? EvaIcons.heart
                                      : EvaIcons.heartOutline,
                                  color: Color(0xffEB5890),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailSearch(
                          provider: widget.provider,
                        )));
          }),
    );
  }
}
