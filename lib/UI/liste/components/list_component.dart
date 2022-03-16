import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/UI/liste/screens/list_details.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';

import 'common_card.dart';

class ListComponent extends StatelessWidget {
  final TaskList taskList;
  final AnimationController animationController;
  final Animation<double> animation;

  const ListComponent(
      {Key? key, required this.animationController, required this.animation,required this.taskList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ListDetails(taskList: taskList,)));
        },
        child: CommonCard(
          color: whiteColor,
          radius: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.9,
                  child: Image.network(
                    taskList.imageUrl,
                    fit: BoxFit.cover,
                  ),
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
                            flex:9,
                            child: Text(
                              taskList.title,
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              children: [
                                const Icon(EvaIcons.bookmark,size: 14,color: primaryColor,),
                                Text(
                                  '25',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(EvaIcons.pricetags,size: 15,color: primaryColor,),
                          Text(
                            taskList.tags[0],
                            // Helper.getRoomText(hotelInfo.roomData!),
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: primaryColor),
                          ),
                        ],
                      ),
                      Text(
                        taskList.tasks.length.toString()+'\ttaches',
                        // Helper.getRoomText(hotelInfo.roomData!),
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ],
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
