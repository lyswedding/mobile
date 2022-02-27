import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/favorite/screens/favoritePage.dart';
import 'package:lys_wedding/favorite/screens/favorite_tab.dart';
import 'package:lys_wedding/home/screens/home.dart';
import 'package:lys_wedding/search/screens/search.dart';
import 'package:lys_wedding/liste/screens/liste_page.dart';
import 'package:lys_wedding/profil/screens/profil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController();
  int currentIndex = 0;
  final PersistentTabController _controller= PersistentTabController(initialIndex: 0);

  final screens =  [
    HomeDetails(),
    SearchPage(),
    ListePage(),
    FavoritePage(),
    ProfilPage()
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.home),
        title: ("Home"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.search),
        title: ("Search"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.file),
        title: ("List"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.heart),
        title: ("Favorite"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.person),
        title: ("Profile"),
        activeColorPrimary: primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12, // Choose the nav bar style with this property.
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