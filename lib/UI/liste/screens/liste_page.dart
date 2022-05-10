import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/liste/components/filterChip.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/liste/components/list_component_horizontal.dart';
import 'package:lys_wedding/UI/profil/screens/user_lists.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/dio_service.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/tags.services.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'add-lists.dart';

class ListePage extends StatefulWidget {
  @override
  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  bool isInCall = true;
  List<TaskList> taskLists = [];
  List<TaskList> foundTaskLists = [];
  List<TaskList> userTaskLists = [];
  List<TaskList> foundUserTaskLists = [];
  var toRemove = [];
  List<String> tags = [];
  TextEditingController searchController = TextEditingController();

  callAllListes() {
    ListCalls.getAdminLists().then((res) {
      setState(() {
        taskLists = res;

      });
    });
    foundTaskLists = taskLists;
    setState(() {
      isInCall = false;
    });
  }

  callAllUserListes() {
    setState(() {
      isInCall = true;
    });
    ListCalls.getUserTaskLists().then((res) {
      setState(() {
        print('*******************');
        print(res.toString());
        userTaskLists = res;
      });
    });
    setState(() {
      isInCall = false;
    });
  }

  callTagsListes() {
    setState(() {
      isInCall = true;
    });
    TagsServices.getUniqueTags().then((res) {
      setState(() {
        print('*******************');
        print(res.toString());
        tags = res;
      });
    });
    setState(() {
      isInCall = false;
    });
  }

  _removeByTags(text) {
    for (var taskList in foundTaskLists) {
      for (var tag in taskList.tags) {
        if(tag == text){
          print(taskList.title);
          setState(() {
            toRemove.add(taskList);
          });
        }
      }
    }
    setState(() {
      foundTaskLists.removeWhere( (e) => toRemove.contains(e));
    });

    if (foundTaskLists.isEmpty) {
      print('list is empty');
        callAllListes();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    callAllListes();
    callAllUserListes();
    callTagsListes();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isInCall,
      progressIndicator: CircularProgressIndicator(),
      child: Scaffold(
        backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Liste",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Container(
                //  Transform.translate(
                // offset: const Offset(10, 0),
                padding: EdgeInsets.only(top: 10),
                // margin: EdgeInsets.symmetric(vertical: 5),

                child: Image.asset(
                  "images/adel.png",
                  height: 60,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                    CommonTextFieldView(
                      onChanged: (String text) {
                        _runFilter(text);
                      },
                      hintText: 'search',
                      controller: searchController,
                    ),
                    _buildCategories(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My lists',
                          style: titleTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserListPage(
                                              tasksLists: userTaskLists,
                                            )))
                                .then((value) => callAllUserListes());
                          },
                          child: Text(
                            'view more',
                            style: regularTextStyle,
                          ),
                        ),
                      ],
                    ),
                    for (int i = 0; i < userTaskLists.length; i++)
                      _buildListUser(i),
                    TextButton(
                        onPressed: () {
                          checkIfTokenExists(() {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddList(),
                              ),
                            );
                          }, context);
                        },
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: secondaryColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    EvaIcons.plusSquareOutline,
                                    size: 24,
                                    color: secondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Add new List",
                                    style: subTitleTextStyle.copyWith(
                                        color: secondaryColor),
                                  ),
                                ],
                              ),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suggested lists',
                          style: titleTextStyle,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => UserListPage(
                        //                   tasksLists: taskLists,
                        //                 )));
                        //   },
                        //   child: Text(
                        //     'view more',
                        //     style: regularTextStyle,
                        //   ),
                        // ),
                      ],
                    ),
                    // _buildListUser(),
                  ] +
                  getPList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            checkIfTokenExists(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddList(),
                  ));
            }, context);
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                    itemCount: tags.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool selected = false;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: const Interval((1 / 6) * 5, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();
                      return FilterChipWidget(
                        //backgroundColor: primaryColor,
                        chipName: tags[index],
                        onSelect: (bool value) {
                          _filterByTags(tags[index].toString());
                        },
                        onDeSelect: (){
                          _removeByTags(tags[index].toString());
                        },
                      );
                    }),
              )),
        ));
  }

  Widget _buildListUser(index) {
    var animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval((1 / 6) * 10, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
    return ListItemHorizontal(
        taskListData: userTaskLists[index],
        animationController: animationController,
        animation: animation);
  }

  Widget _buildListAdminLists() {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: 400,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // crossAxisSpacing: 5,
                  // mainAxisSpacing: 5,
                  childAspectRatio: 0.6),
              itemCount: taskLists.length,
              scrollDirection: Axis.vertical,
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
                  isSelected: false,
                  taskList: taskLists[index],
                  animationController: animationController,
                  animation: animation,
                );
              }),
        )
      ],
    ));
  }

  _filterByTags(text) {
    for (var element in taskLists) {
      if (element.tags.contains(text)) {
        print(element.title);
          if (foundTaskLists.contains(element) == false) {
            setState(() {
              foundTaskLists.add(element);
            });
          }
      }
    }

    taskLists = foundTaskLists;

    userTaskLists.forEach((element) {
      if (element.tags.contains(text)) {
        setState(() {
          foundUserTaskLists.add(element);
        });
      }
    });
    userTaskLists = foundUserTaskLists;
    print(foundTaskLists);
    // print(foundUserTaskLists);
  }

  void _runFilter(String enteredKeyword) {
    List<TaskList> results = [];
    List<TaskList> userResults = [];
    // if (enteredKeyword.isEmpty) {
    //   // if the search field is empty or only contains white-space, we'll display all users
    //   setState(() {
    //     results = taskLists;
    //
    //   });
    // } else {
    //   results = taskLists
    //       .where((taskList) => taskList.title!.toLowerCase()
    //       .contains(enteredKeyword.toLowerCase()))
    //       .toList();
    // }

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      userResults = userTaskLists;
    } else {
      userResults = userTaskLists
          .where((userTaskList) => userTaskList.title!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      // taskLists = results;
      userTaskLists = userResults;
    });
  }

  List<Widget> getPList() {
    List<Widget> noList = [];
    var cout = 0;
    final columCount = 2;
    for (var i = 0; i < taskLists.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = taskLists[cout];
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / taskLists.length) * cout, 1.0,
                  curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          listUI.add(Expanded(
            child: ListComponent(
              isSelected: false,
              taskList: date,
              animation: animation,
              animationController: animationController,
            ),
          ));
          cout += 1;
        } catch (e) {}
      }
      noList.add(
        Row(
          mainAxisSize: MainAxisSize.max,
          children: listUI,
        ),
      );
    }
    return noList;
  }
}
