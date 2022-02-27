import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/animation.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/liste/components/common_card.dart';
import 'package:lys_wedding/liste/screens/list_details.dart';

class ListItemHorizontal extends StatefulWidget {
  final bool isShowDate;
  final AnimationController animationController;
  final Animation<double> animation;

  const ListItemHorizontal(
      {Key? key,
        required this.animationController,
        required this.animation,
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
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ListDetails()));
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
                            child:Image.asset('images/9.jpg',fit: BoxFit.cover,)
                        ),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'titleTxt',
                                      maxLines: 2,
                                      textAlign: TextAlign.left,

                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.bookmark),
                                        Text(
                                          'subTxt',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.label_important,
                                          size: 16,
                                          color: primaryColor,
                                        ),
                                        Text(
                                          " furniture,cuisine ",
                                          overflow: TextOverflow.ellipsis,

                                        ),

                                      ],
                                    ),
                                    //Helper.ratingStar(),
                                  ],
                                ),

                                Expanded(
                                  child: Text(
                                    '16 taches',
                                    overflow:
                                    TextOverflow.ellipsis,
                                  ),
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
