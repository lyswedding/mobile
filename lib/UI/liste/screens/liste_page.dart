import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/liste/components/filterChip.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/liste/components/list_component_horizontal.dart';
import 'package:lys_wedding/UI/profil/screens/profil.dart';
import 'package:lys_wedding/UI/profil/screens/user_lists.dart';
import 'package:lys_wedding/models/model_profil.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/progress.dart';
import 'package:lys_wedding/services/dio_service.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/tags.services.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add-lists.dart';

class ListePage extends StatefulWidget {
  @override
  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  bool isInCall = true;
  bool isLoaded = false;
  bool islogued = false;

  UserApi item = UserApi();
  final ServiceProfil service = ServiceProfil();
  List<TaskList> taskLists = [];
  List<TaskList> foundTaskLists = [];
  List<TaskList> userTaskLists = [];
  List<TaskList> foundUserTaskLists = [];
  var toRemove = [];
  List<String> tags = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  call() async {
    islogued = await ifTokenExist();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    Provider.of<ListCalls>(context, listen: false).getAdminLists();
    Provider.of<ListCalls>(context, listen: false).getUserTaskLists();
    Provider.of<TagsServices>(context, listen: false).getUniqueTags();
    Provider.of<FavoriteCalls>(context, listen: false).getFavorite();
    taskLists = Provider.of<ListCalls>(context, listen: false).tasksLists;
    _refreshController.refreshCompleted();
  }

  _removeByTags(text) {
    for (var taskList in taskLists) {
      for (var tag in taskList.tags) {
        if (tag == text) {
          print(taskList.title);
          setState(() {
            toRemove.add(taskList);
          });
        }
      }
    }
    setState(() {
      taskLists.removeWhere((e) => toRemove.contains(e));
    });

    if (taskLists.isEmpty) {
      print('list is empty');
      taskLists = Provider.of<ListCalls>(context, listen: false).tasksLists;
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 4000), () {
      setState(() {
        isLoading = false;
      });
    });
    // TODO: implement initState
    Provider.of<ListCalls>(context, listen: false).getAdminLists();
    Provider.of<ListCalls>(context, listen: false).getUserTaskLists();
    Provider.of<TagsServices>(context, listen: false).getUniqueTags();
    Provider.of<FavoriteCalls>(context, listen: false).getFavorite();
    taskLists = Provider.of<ListCalls>(context, listen: false).tasksLists;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
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
              padding: const EdgeInsets.only(
                right: 18.0,
              ),
              child: isLoading
                  ? getShimmerLoadingcircle(
                      18,
                    )
                  : InkWell(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            Provider.of<ServiceProfil>(context, listen: false)
                                .userImageUrl),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilPage()));
                      },
                    ),
            ),
          ],
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
              ) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [

                connected
                    ?  SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Padding(
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
                                        tasksLists: Provider.of<ListCalls>(
                                            context,
                                            listen: false)
                                            .userTasksLists,
                                      ))).then((value) =>
                                  Provider.of<ListCalls>(context, listen: false)
                                      .getUserTaskLists());
                            },
                            child: Text(
                              'view more',
                              style: regularTextStyle,
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0;
                      i <
                          Provider.of<ListCalls>(context, listen: false)
                              .userTasksLists
                              .length;
                      i++)
                        _buildListUser(i),

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
            )
                    : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(EvaIcons.wifiOff,size: 70,),
                      Text(
                        'Turn on your internet connection',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'There are no bottons to push :)',
              ),
              Text(
                'Just turn off your internet.',
              ),
            ],
          ),
        ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {
            checkIfTokenExists(() {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddList(),
                      ))
                  .then((value) =>
                      Provider.of<ListCalls>(context, listen: false)
                          .getUserTaskLists());
            }, context)
                .then((value) => Provider.of<ListCalls>(context, listen: false)
                    .getUserTaskLists());
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
                    itemCount: Provider.of<TagsServices>(context, listen: false)
                        .servicesLists
                        .length,
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
                        chipName:
                            Provider.of<TagsServices>(context, listen: false)
                                .servicesLists[index],
                        onSelect: (bool value) {
                          _filterByTags(
                              Provider.of<TagsServices>(context, listen: false)
                                  .servicesLists[index]
                                  .toString());
                        },
                        onDeSelect: () {
                          _removeByTags(
                              Provider.of<TagsServices>(context, listen: false)
                                  .servicesLists[index]
                                  .toString());
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
    return isLoading
        ? getShimmerLoading(80, 400)
        : ListItemHorizontal(
            taskListData: Provider.of<ListCalls>(context, listen: false)
                .userTasksLists[index],
            animationController: animationController,
            animation: animation);
  }

  _filterByTags(text) {
    for (var element
        in Provider.of<ListCalls>(context, listen: false).tasksLists) {
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

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      //callAllListes();
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

  bool? checkIsFavorite(List<String> list, listId) {
    if (list.contains(listId)) {
      return true;
    } else {
      return false;
    }
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
            child: isLoading
                ? getShimmerLoading(250, 200)
                : ListComponent(
                    taskList: date,
                    animation: animation,
                    animationController: animationController,
                    isSelected: checkIsFavorite(
                        Provider.of<FavoriteCalls>(context, listen: false)
                            .favoriteListId,
                        date.id)!,
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
