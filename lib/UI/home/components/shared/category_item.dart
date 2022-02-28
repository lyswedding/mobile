import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/common_card.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';


class CategoryItem extends StatelessWidget {
  final String text;
  final String image;
  final AnimationController animationController;
  final Animation<double> animation;
  CategoryItem(this.text,this.image,this.animationController,this.animation);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animationController: animationController,
      animation: animation,
      child: CommonCard(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(5)),
          child: AspectRatio(
            aspectRatio: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.category,size: 24,),
                //Image.asset(image,),
                Text('data',style: subTitleTextStyle,),
              ],
            ),
          ),
        ) ,
        color: whiteColor,
      ),
    );
  }
}


class CategoryItemList extends StatelessWidget {
  final String text;
  final String image;
  final AnimationController animationController;
  final Animation<double> animation;
  CategoryItemList(this.text,this.image,this.animationController,this.animation);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animationController: animationController,
      animation: animation,
      child: CommonCard(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          child: AspectRatio(
            aspectRatio: 3,
            child: Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(EvaIcons.pricetags,size: 16,color: whiteColor,),
                Text('data',style: subTitleTextStyle.copyWith(color: whiteColor),),
              ],
            )),
          ),
        ) ,
        color: primaryColor,
      ),
    );
  }
}