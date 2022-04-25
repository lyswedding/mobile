// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lys_wedding/UI/favorite/screens/favoritePage.dart';
// import 'package:lys_wedding/UI/home/screens/home.dart';
// import 'package:lys_wedding/UI/liste/screens/liste_page.dart';
// import 'package:lys_wedding/UI/profil/screens/profil.dart';
// import 'package:lys_wedding/UI/profil/screens/user_lists.dart';
// import 'package:lys_wedding/UI/search/screens/search.dart';
// import 'package:lys_wedding/shared/constants.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   PageController pageController = PageController();
//   int currentIndex = 0;
//    PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);
//   @override
//   void initState() {
//     super.initState();
//     _controller = PersistentTabController(initialIndex: 0);
//   }
//   final screens = [
//     const HomeDetails(),
//     SearchPage(),
//     const ListePage(),
//     const FavoritePage(),
//     const ProfilPage()
//   ];
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: const Icon(EvaIcons.home),
//         title: ("Home"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(EvaIcons.search),
//         title: ("Search"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(EvaIcons.file),
//         title: ("List"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(EvaIcons.heart),
//         title: ("Favorite"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(EvaIcons.person),
//         title: ("Profile"),
//         activeColorPrimary: primaryColor,
//         inactiveColorPrimary: CupertinoColors.systemGrey,
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: screens,
//       items: _navBarsItems(),
//       confineInSafeArea: true,
//       backgroundColor: Colors.white, // Default is Colors.white.
//       handleAndroidBackButtonPress: true, // Default is true.
//       resizeToAvoidBottomInset:
//           true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
//       stateManagement: true, // Default is true.
//       hideNavigationBarWhenKeyboardShows:
//           true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         colorBehindNavBar: Colors.white,
//       ),
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: const ItemAnimationProperties(
//         // Navigation Bar's items animation properties.
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: const ScreenTransitionAnimation(
//         // Screen transition animation on change of selected tab.
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle:
//           NavBarStyle.style12, // Choose the nav bar style with this property.
//     );
//   }
// }


import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/favorite/screens/favoritePage.dart';
import 'package:lys_wedding/UI/liste/screens/liste_page.dart';
import 'package:lys_wedding/UI/profil/screens/profil.dart';
import 'package:lys_wedding/UI/search/screens/search.dart';
import 'package:lys_wedding/shared/constants.dart';

import 'home.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    HomeDetails(),
    SearchPage(),
    ListePage(),
    FavoritePage(),
    ProfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.file),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.heart),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.person),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        selectedLabelStyle: regularTextStyle,
        onTap: _onItemTapped,
      ),
    );
  }
}

