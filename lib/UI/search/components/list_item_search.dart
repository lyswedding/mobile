import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/common_card.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';

class ListItem {
  ListItem({required this.label, required this.image});
  String label;
  String image;
}

class ItemListSearch<T> extends StatelessWidget {
  const ItemListSearch({
    Key? key,
    required this.text,
    required this.items,
    required this.animation,
    required this.animationController,
  }) : super(key: key);

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
                        child: Image.asset(
                          'images/14.jpg',
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
                                text,
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
                                    "aaa",
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
                        onTap: () {},
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
