import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/screens/task_update.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';

import 'common_card.dart';

class TaskComponent extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  final Animation<double> animation;
  final Task task;

  const TaskComponent({
    required this.text,
    required this.animation,
    required this.animationController,
    required this.task
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListCellAnimationView(
        animation: animation,
        animationController: animationController,
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskUpdate(task: task ,)));
          },
          child: CommonCard(
            color: whiteColor,
            radius: 10,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      //ProfilePicture(restaurantId: hotelData.id,),
                      AspectRatio(
                        aspectRatio: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffD8E2DC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Text(
                                        task.title,
                                        textAlign: TextAlign.left,
                                        style: titleTextStyle,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            EvaIcons.pricetags,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 5,),
                                          Text(
                                            task.tags[0],
                                            overflow: TextOverflow.ellipsis,
                                            style: subTitleTextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  task.description,
                                  style: subTitleTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  task.cost.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: subTitleTextStyle,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      EvaIcons.calendar,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      task.dueDate,
                                      overflow: TextOverflow.ellipsis,
                                      style: subTitleTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      EvaIcons.bookmark,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      task.nbUse.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: subTitleTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
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
