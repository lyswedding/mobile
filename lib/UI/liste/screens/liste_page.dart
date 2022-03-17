import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
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
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'add-lists.dart';

class ListePage extends StatefulWidget {
  const ListePage({Key? key}) : super(key: key);

  @override
  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  bool isInCall = false;
  List<TaskList> taskLists = [];
  final List<TaskList> foundTaskLists = [];
  List<TaskList> userTaskLists = [];
  List<TaskList> foundUserTaskLists = [];
  List<String> tags = [];

  callAllListes() {
    setState(() {
      isInCall = true;
    });
    ListCalls.getAdminLists().then((res) {
      setState(() {
        taskLists = res;
      });
    });
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
      opacity: 0.5,
      progressIndicator: const CircularProgressIndicator(),
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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBar(
                  onchanged: (enteredKeyword) {
                    _runFilter(enteredKeyword);
                  },
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
                                    ))).then((value) => callAllUserListes());
                      },
                      child: Text(
                        'view more',
                        style: regularTextStyle,
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < 2; i++) _buildListUser(i),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suggested lists',
                      style: titleTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserListPage(
                                      tasksLists: userTaskLists,
                                    )));
                      },
                      child: Text(
                        'view more',
                        style: regularTextStyle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildListAdminLists(),
                ),
                // _buildListUser(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddList(),
                ));
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
        setState(() {
          foundTaskLists.add(element);
        });
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

}

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final Function onSelect;
  FilterChipWidget({Key? key, this.chipName = '', required this.onSelect})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        padding: const EdgeInsets.all(4.0),
        label: Text(widget.chipName),
        labelStyle:
            regularTextStyle.copyWith(color: Colors.white, fontSize: 15),
        selected: _isSelected,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: secondaryColor,
        onSelected: (isSelected) {
          setState(() {
            _isSelected = isSelected;
            widget.onSelect(isSelected);
          });
        },
        selectedColor: primaryColor,
      ),
    );
  }
}
