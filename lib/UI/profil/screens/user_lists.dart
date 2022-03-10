import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/liste/components/list_component.dart';
import 'package:lys_wedding/UI/search/components/list_item_search.dart';
import 'package:lys_wedding/models/taskList.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';
import 'package:lys_wedding/shared/constants.dart';

import '../../../models/List_search.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

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

  callAllListes() {
    setState(() {
      isInCall = true;
    });
    ListCalls.getUserLists().then((res) {
      setState(() {
        taskLists = res;
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
            "Favorite",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
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
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                SizedBox(
                  height: screenHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildListFavoriteLists(),
                  ),
                ),
              ]),
            )));
  }

  Widget _buildListFavoriteLists() {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 800,
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

  Widget _buildListFavoriteProviders() {
    return SingleChildScrollView(
        child: SizedBox(
          height: 800,
          child: ListView.builder(
              itemCount: search.length,
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

                return ItemListSearch(
                  provider: search[index],
                  animation: animation,
                  animationController: animationController,
                  text: '',
                  //     .map((e) => ListItem(image: e.cover, label: e.name))
                  //     .toList()
                );
              }),
        ));
  }
}
