import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/liste/components/list_component_horizontal.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';

import '../../../models/List_search.dart';

class UserListPage extends StatefulWidget {
  final List<TaskList> tasksLists;
  UserListPage({required this.tasksLists});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage>
    with TickerProviderStateMixin {
  String valuechoose = 'prestataire';
  late AnimationController animationController;
  bool isInCall = false;
  bool isLoaded = false;
  final ServiceList service = ServiceList();
  List<Provider> search = [];
  List<TaskList> taskLists = [];

  // callAllListes() {
  //   setState(() {
  //     isInCall = true;
  //   });
  //   ListCalls.getUserLists().then((res) {
  //     setState(() {
  //       taskLists = res;
  //     });
  //   });
  //   setState(() {
  //     isInCall = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    // callAllListes();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: scaffoldBGColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "My lists",
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
          child: _buildListFavoriteProviders(),
        ));
  }

  Widget _buildListFavoriteProviders() {
    return ListView.builder(
        itemCount: widget.tasksLists.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve:
                  const Interval((1 / 6) * 5, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();

          return Dismissible(
            background: Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        EvaIcons.trash,
                        color: primaryColor,
                      ),
                    ],
                  ),
                ),
                color: Colors.red),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              showAlertDialog(context, widget.tasksLists[index].id);
            },
            child: ListItemHorizontal(
                taskListData: widget.tasksLists[index],
                animationController: animationController,
                animation: animation
                //     .map((e) => ListItem(image: e.cover, label: e.name))
                //     .toList()
                ),
          );
        });
  }

  _deleteTask(idList) async {
    print(idList);
    await ListCalls.deleteTaskList(idList).then((value) {
      if (value == 200) {
        showToast(context: context, msg: "Liste des tâches supprimée");
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });

    setState(() {
      isInCall = true;
    });
  }

  showAlertDialog(BuildContext context, idList) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        _deleteTask(idList);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
