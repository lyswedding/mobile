import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/liste/components/task_component.dart';
import 'package:lys_wedding/UI/liste/screens/list_tasks.dart';
import 'package:lys_wedding/UI/liste/screens/update_list.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:readmore/readmore.dart';

class ListDetails extends StatefulWidget {
  final TaskList taskList;
  ListDetails({required this.taskList});

  @override
  _ListDetailsState createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
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
        title: const Text(
          "List details",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.7,
                      child: Image.network(
                        widget.taskList.imageUrl.toString(),
                        fit: BoxFit.cover,
                      ),
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
                      top: 16,
                      right: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(0.8),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.taskList.title.toString(),
                    style: titleTextStyle,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateList(taskList: widget.taskList)));
                    },
                      child: const Icon(EvaIcons.edit,size: 24,color: primaryColor,)),
                ],
              ),
              _buildCategories(),
              const SizedBox(
                height: 10,
              ),
              ReadMoreText(
                widget.taskList.description.toString(),
                trimLines: 2,
                style: regularTextStyle,
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle:
                    regularTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: titleTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListTasks(
                                    listTasks: widget.taskList.tasks!,
                                idList: widget.taskList.id,
                                  )));
                    },
                    child: Text(
                      'view more',
                      style: regularTextStyle,
                    ),
                  ),
                ],
              ),
              for (int i = 0; i < widget.taskList.tasks!.length; i++)
                _buildListTasks(i),
              Text(
                'Relates lists',
                style: titleTextStyle,
              ),
              // Expanded(
              //   child: Row(
              //     children: [
              //       for(int i=0;i<4;i++)
              //         buildRelatedLists(),
              //     ],
              //   ),
              // )
              //_buildListFavoriteLists(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
        child: SizedBox(
      height: 40,
      child: ListView.builder(
          itemCount: widget.taskList.tags!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval((1 / 6) * 5, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            );
            animationController.forward();
            return CategoryItemList(
                widget.taskList.tags![index], 'images/9.jpg', animationController, animation);

          }),
    ));
  }

  _buildListTasks(int i) {
    var animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval((1 / 6) * 5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
    return TaskComponent(
      task: widget.taskList.tasks![i],
      animationController: animationController,
      text: 'text',
      animation: animation,
      idList: widget.taskList.id,
    );
  }

  buildRelatedLists() {
    var animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval((1 / 6) * 5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
    return ListComponent(
        taskList: widget.taskList,
        animationController: animationController,
        animation: animation,
);
  }

  Widget _buildListFavoriteLists() {
    return SizedBox(
      height: 400,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var animation = Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const Interval((1 / 6) * 5, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            );
            animationController.forward();
            return ListComponent(
                taskList: widget.taskList,
                animationController: animationController,
                animation: animation,);
          }),
    );
  }
}
