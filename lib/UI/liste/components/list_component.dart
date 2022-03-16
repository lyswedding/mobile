import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/liste/screens/list_details.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';

import 'common_card.dart';

class ListComponent extends StatefulWidget {
  final TaskList taskList;
  final AnimationController animationController;
  final Animation<double> animation;

  const ListComponent({
    Key? key,
    required this.animationController,
    required this.animation,
    required this.taskList,
  }) : super(key: key);

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  bool isInCall = false;
  bool isSelected = false;
  callAddToFavorite(id) async {
    await FavoriteCalls.addListToFavorite(id).then((value) {
      print(value);
      print(value.statusCode);
      if (value.statusCode == 201) {
        showToast(
            context: context, msg:'Liste des tâches mise en favoris');
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });
    setState(() {
      isInCall = true;
    });
  }

  deleteFromFavorites(id) async {
    await FavoriteCalls.deletTaskListFromFavorite(id).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        showToast(
            context: context, msg:'Liste des tâches retiré de favoris');
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListDetails(
                        taskList: widget.taskList,
                      )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.5,
          child: CommonCard(
            color: whiteColor,
            radius: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 0.9,
                        child: Image.network(
                          widget.taskList.imageUrl.toString(),
                          fit: BoxFit.cover,
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
                                setState(() {
                                  isSelected = !isSelected;
                                });
                                if (isSelected) {
                                  callAddToFavorite(widget.taskList.id);
                                } else {
                                  deleteFromFavorites(widget.taskList.id);
                                }
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Text(
                                widget.taskList.title.toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  EvaIcons.bookmark,
                                  size: 14,
                                  color: primaryColor,
                                ),
                                Text(
                                  '25',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              EvaIcons.pricetags,
                              size: 15,
                              color: primaryColor,
                            ),
                            Text(
                              widget.taskList.tags![0].toString(),
                              // Helper.getRoomText(hotelInfo.roomData!),
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          widget.taskList.tasks!.length.toString() + '\ttaches',
                          // Helper.getRoomText(hotelInfo.roomData!),
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
