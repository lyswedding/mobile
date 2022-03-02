import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/common_card.dart';
import 'package:lys_wedding/UI/liste/screens/list_details.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';

class ListItemHorizontal extends StatefulWidget {
  final bool isShowDate;
  final AnimationController animationController;
  final Animation<double> animation;
  final TaskList taskListData;

  const ListItemHorizontal(
      {Key? key,
      required this.animationController,
      required this.animation,
      required this.taskListData,
      this.isShowDate: false})
      : super(key: key);

  @override
  State<ListItemHorizontal> createState() => _ListItemHorizontalState();
}

class _ListItemHorizontalState extends State<ListItemHorizontal> {
  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: widget.animation,
      animationController: widget.animationController,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListDetails(taskList: widget.taskListData,)));
          },
          child: CommonCard(
            color: whiteColor,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: AspectRatio(
                aspectRatio: 4,
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //ProfileCarousel(restaurantId: widget.hotelData.id,),
                        AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              widget.taskListData.imageUrl,
                              fit: BoxFit.cover,
                            )),
                        Expanded(
                          //flex: 8,
                          child: Container(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width >= 360
                                    ? 12
                                    : 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.taskListData.title,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: const [
                                        Icon(Icons.bookmark),
                                        Text(
                                          '125',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Icon(
                                          EvaIcons.pricetags,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          widget.taskListData.tags.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      widget.taskListData.tasks.length
                                              .toString() +
                                          '\ttaches',
                                      overflow: TextOverflow.ellipsis,
                                      style: titleTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize:12),
                                    ),
                                    //Helper.ratingStar(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
