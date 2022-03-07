import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/common_card.dart';
import 'package:lys_wedding/UI/liste/screens/list_tasks.dart';
import 'package:lys_wedding/UI/liste/screens/task_update.dart';
import 'package:lys_wedding/UI/search/screens/detail_search/screens/detail_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';

import '../../liste/screens/list_details.dart';

class ItemListSearch<T> extends StatelessWidget {
  const ItemListSearch({
    Key? key,
    required this.provider,
    required this.text,
    required this.items,
    required this.animation,
    required this.animationController,
  }) : super(key: key);
  final Provider provider;
  final List<T>? items;
  final String text;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CommonCard(
          color: whiteColor,
          radius: 10,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    //ProfilePicture(restaurantId: hotelData.id,),
                    AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(
                          provider.cover,
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
                                provider.name,
                                textAlign: TextAlign.left,
                                style: titleTextStyle,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    size: 12,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Text(
                                    provider.description,
                                    overflow: TextOverflow.ellipsis,
                                    style: subTitleTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'subTxt',
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
                              "aaa",
                              overflow: TextOverflow.ellipsis,
                              style: subTitleTextStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailSearch(
                                        provider: provider,
                                      )));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.favorite_border_rounded,
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
    );
  }
}
