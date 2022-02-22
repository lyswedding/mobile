import 'package:flutter/material.dart';
import 'package:lys_wedding/liste/components/list_component_horizontal.dart';

class ListUser extends StatefulWidget {
  const ListUser({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height, width;

  @override
  State<ListUser> createState() => _ListUserState();
}
@override
late AnimationController animationController;


class _ListUserState extends State<ListUser> with TickerProviderStateMixin{

  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 800,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: const Interval((1 / 6) *10, 1.0,
                      curve: Curves.fastOutSlowIn),
                ),
              );
              animationController.forward();
              return ListItemHorizontal(animationController: animationController, animation: animation);
            }
          ),
        )
      ],
    ));
  }
}
