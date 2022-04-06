import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/shared/constants.dart';

class ResultPage extends StatefulWidget {
  final List<Provider> resultList;
  ResultPage({Key? key,required this.resultList}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin{
  late AnimationController _animationController;


  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(duration: Duration(milliseconds: 400),vsync: this);
    _animationController.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Result page",
          style: titleTextStyle.copyWith(fontSize: 20),
        ),
      ),
      body: Container(
        child:  widget.resultList.isNotEmpty?ListView.builder(
          itemCount: widget.resultList.length,
          padding: EdgeInsets.only(top: 8, bottom: 16),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            var count = widget.resultList.length > 10 ? 10 : widget.resultList.length;
            var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn)));
            _animationController.forward();
            //Finished hotel data list and UI View
            return ItemListSearch(
              provider: widget.resultList[index],
              animation: animation,
              animationController: _animationController, text: 'text',
            );
          },
        ):Container(
          child: Text('no found Result'),
        ),
      ),
    );
  }
}
