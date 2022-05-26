import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/common_card.dart';
import 'package:lys_wedding/shared/animation.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItem extends StatefulWidget {
  final String text;
  final String image;
  final AnimationController animationController;
  final Animation<double> animation;
  final Function onTapSelected;
  final Function onUnSelect;
  CategoryItem(this.text, this.image, this.animationController, this.animation,
      this.onTapSelected, this.onUnSelect);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isSelected = false;
  bool isLoaded = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 3000), () {
      setState(() {
        isLoaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animationController: widget.animationController,
      animation: widget.animation,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            print(isSelected);
            if (isSelected) {
              widget.onTapSelected();
            } else {
              widget.onUnSelect();
            }
          });
        },
        child: CommonCard(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(const Radius.circular(5)),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    widget.image,
                    height: 30,
                    width: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.text,
                      style: subTitleTextStyle.copyWith(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          color: isSelected ? Colors.pink[300] : Colors.white,
        ),
      ),
    );
  }
}

class CategoryItemList extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  final Animation<double> animation;
  CategoryItemList(
    this.text,
    this.animationController,
    this.animation,
  );

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
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  EvaIcons.pricetags,
                  size: 16,
                  color: whiteColor,
                ),
                Text(
                  text,
                  style: subTitleTextStyle.copyWith(color: whiteColor),
                ),
              ],
            )),
          ),
        ),
        color: primaryColor,
      ),
    );
  }
}
