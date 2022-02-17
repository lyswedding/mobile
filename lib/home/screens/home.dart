import 'package:flutter/material.dart';
import 'package:lys_wedding/home/screens/favorite/screens/favoritePage.dart';
import 'package:lys_wedding/home/screens/homedetails.dart';
import 'package:lys_wedding/home/screens/profil/screens/profil.dart';
import 'package:lys_wedding/home/screens/search/screens/search.dart';

import 'liste/screens/liste.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  int currentIndex = 0;

  final screens = const [
    HomeDetails(),
    SearchPage(),
    ListePage(),
    FavoritePage(),
    ProfilPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) => setState(
          () => currentIndex = index,
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'search',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'list',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'favorite',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profil',
              backgroundColor: Colors.white),
        ],
      ),
    );
  }
}




// SingleChildScrollView(
//           controller: pageController,
//           child: Column(children: [
//             Container(
//               padding: const EdgeInsets.fromLTRB(10, 40, 30, 0),
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Image.asset("images/icon.png", height: 50),
//                     Container(
//                       width: 50,
//                       child: Text("Bonjour adel"),
//                     ),
//                     Spacer(flex: 2),
//                     Padding(
//                         padding: EdgeInsets.only(right: 20.0),
//                         child: GestureDetector(
//                           child: Icon(
//                             Icons.search,
//                           ),
//                         )),
//                     Icon(Icons.notifications),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: 150,
//               padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
//               margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
//               child: Center(
//                 child: Text(
//                   "We are here to help you planning your wedding",
//                   style: TextStyle(fontSize: 25),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                   color: Colors.orange),
//             ),
//             Container(
//                 margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
//                 child: Row(
//                   children: [Text('Categories')],
//                 )),
//             SingleChildScrollView(
//                 child: Column(
//               children: [
//                 SizedBox(
//                   height: 100,
//                   child: ListView.builder(
//                     itemCount: 10,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => Container(
//                       height: 60,
//                       width: 60,
//                       padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
//                       margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           color: Colors.orange),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//             Container(
//                 margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
//                 child: Row(
//                   children: const [Text('Bon Plan')],
//                 )),
//             SingleChildScrollView(
//                 child: Column(
//               children: [
//                 SizedBox(
//                   height: 180,
//                   child: ListView.builder(
//                     itemCount: 10,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => Container(
//                       height: 150,
//                       width: 250,
//                       padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
//                       margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           color: Colors.orange),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//             Container(
//                 margin: const EdgeInsets.fromLTRB(10, 30, 0, 0),
//                 child: Row(
//                   children: const [
//                     Text(
//                       'Popular lists',
//                       style: TextStyle(fontFamily: 'Playfair Display'),
//                     )
//                   ],
//                 )),
//             SingleChildScrollView(
//                 child: Column(
//               children: [
//                 SizedBox(
//                   height: 200,
//                   child: ListView.builder(
//                     itemCount: 10,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => Container(
//                       height: 60,
//                       width: 150,
//                       padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
//                       margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                           color: Colors.orange),
//                     ),
//                   ),
//                 )
//               ],
//             )),
//           ])),