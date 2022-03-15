import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/home/components/shared/category_item.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/liste/components/list_component_horizontal.dart';
import 'package:lys_wedding/UI/profil/screens/user_lists.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/dio_service.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
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
  List<TaskList> userTaskLists = [];

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
        userTaskLists=res;
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
                const SearchBar(),
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
                                )));
                      },
                      child: Text(
                        'view more',
                        style: regularTextStyle,
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < 2; i++)
                  _buildListUser(i),
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
              itemCount: 10,
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
                    'text', 'images/9.jpg', animationController, animation);
              }),
        ),
      )),
    );
  }

  Widget _buildListUser(index) {
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: const Interval((1 / 6) * 10, 1.0,
                  curve: Curves.fastOutSlowIn),
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
                        animation: animation);
                  }),
            )
          ],
        ));
  }

}
