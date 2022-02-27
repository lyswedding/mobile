import 'package:flutter/material.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/favorite/components/listsfav.dart';
import 'package:lys_wedding/home/components/shared/category_item.dart';
import 'package:lys_wedding/home/components/shared/search_bar.dart';
import 'package:lys_wedding/liste/screens/add-lists.dart';

class ListePage extends StatefulWidget {
  const ListePage({Key? key}) : super(key: key);

  @override
  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> with TickerProviderStateMixin {
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scaffoldBGColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Liste",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(children: [
              const SearchBar(),
              _buildCategories(),
              const ListUser(height: 65, width: 40)])),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const AddList(),
              ));
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategories(){
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
                        curve: const Interval((1 / 6) *5, 1.0,
                            curve: Curves.fastOutSlowIn),
                      ),
                    );
                    animationController.forward();
                    return CategoryItemList('text','images/9.jpg',animationController,animation);
                  }

              ),
            ),
          )),
    );
  }

}
