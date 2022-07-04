import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/search/components/common_appbar_view.dart';
import 'package:lys_wedding/UI/search/components/slider_view.dart';
import 'package:lys_wedding/UI/search/screens/result_page.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  FilterPage({
    Key? key,
  }) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

List<Service> services = [];
List<ServiceProvider> search = [];
List<ServiceProvider> foundProviders = [];
List<ServiceProvider> foundServices = [];
List<String> selectedlocation = [];
List<String> selectedservices = [];
bool isLoaded = false;

List<String> GovernoratFilterListData = [
  'Tunis',
  'Nabeul',
  'Bizerte',
  'Kef',
  'Zaghouen',
  'Manouba',
  'Ariana',
  'Ben Arous',
  'Touzer',
  'Tataouine',
  'Sfax',
  'Sousse',
  'Kaoirouen',
  'Gafsa'
];
double distValue = 50.0;

class _FilterPageState extends State<FilterPage> {
  // callGetServices() async {
  //   setState(() {
  //     isLoaded = true;
  //   });
  //   services = await CategorieCalls.getAdminServices();
  //
  //   setState(() {
  //     isLoaded = false;
  //   });
  // }

  // fetchSearch() async {
  //   setState(() {
  //     isLoaded = true;
  //   });
  //   search = await ProviderCalls.getPrestataire();
  //   setState(() {
  //     isLoaded = false;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    //callGetServices();
    // fetchSearch();
    Provider.of<ProviderCalls>(context, listen: false).getPrestataire();
    Provider.of<CategorieCalls>(context, listen: false).getAdminServices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBGColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonAppbarView(
            iconData: Icons.close,
            onBackClick: () {
              Navigator.pop(context);
            },
            titleText: "Filter page",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //distanceViewUI(),

                    popularFilter(),
                    governoratFilter(),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor,
                    // boxShadow: const [
                    //   BoxShadow(
                    //       offset: Offset(0, 10),
                    //       blurRadius: 50,
                    //       color: Color(0xffEEEEEE)),
                    // ],
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: whiteColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResultPage(resultList: foundProviders)));
                    },
                    child: Text(
                      "appliquer filtre " + foundProviders.length.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'service',
            textAlign: TextAlign.left,
            style: subTitleTextStyle.copyWith(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Column(
            children: getPList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget governoratFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Governorat',
            textAlign: TextAlign.left,
            style: subTitleTextStyle.copyWith(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Column(
            children: getGList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            "distance from city",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        SliderView(
          distValue: distValue,
          onChnagedistValue: (value) {
            distValue = value;
          },
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getPList() {
    List<Widget> noList = [];
    var cout = 0;
    const columCount = 2;
    for (var i = 0;
        i <
            Provider.of<CategorieCalls>(context, listen: false)
                    .servicesLists
                    .length /
                columCount;
        i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = Provider.of<CategorieCalls>(context, listen: false)
              .servicesLists[cout];
          // final datee = GovernoratFilterListData[cout];
          listUI.add(
            Expanded(
              child: Row(
                children: <Widget>[
                  CustomCheckBox(
                    title: date.title,
                    onTapSelected: () {
                      // if (foundProviders.isNotEmpty) {
                      //   _filterByLocations(date.title, datee);
                      // } else {
                      selectedservices.add(date.title);
                      _filter();
                      // }
                    },
                    onUnSelect: () {
                      selectedservices.remove(date.title);
                      _filter();
                    },
                  ),
                ],
              ),
            ),
          );
          cout += 1;
        } catch (e) {}
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  List<Widget> getGList() {
    List<Widget> noList = [];
    var cout = 0;
    const columCount = 2;
    for (var i = 0; i < GovernoratFilterListData.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = GovernoratFilterListData[cout];
          listUI.add(
            Expanded(
              child: Row(
                children: <Widget>[
                  CustomCheckBox(
                    title: date,
                    onTapSelected: () {
                      selectedlocation.add(date);
                      _filter();
                    },
                    onUnSelect: () {
                      selectedlocation.remove(date);
                      _filter();
                    },
                  )
                ],
              ),
            ),
          );
          cout += 1;
        } catch (e) {}
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  _filterByServices(text) {
    search.forEach((provider) {
      provider.services.forEach((service) {
        // print(service['name']);
        if (service['name'] == text) {
          // print(provider.name);
          setState(() {
            foundProviders.add(provider);
          });
        }
      });
    });
  }

  // if (foundProviders.isEmpty) {
  //   for (var element in search) {
  //     element.services.forEach((service) {
  //       print(service['name']);
  //       if (service['name'] == text) {
  //         print(element.name);
  //         setState(() {
  //           if (foundServices.contains(element) == false)
  //             foundServices.add(element);
  //         });
  //       }
  //     });
  //     foundProviders = foundServices;
  //     // print(foundServices);
  //     // print(foundUserTaskLists);
  //   }
  // } else {
  //   for (var element in foundProviders) {
  //     element.services.forEach((service) {
  //       // print(service['name']);
  //       if (service['name'] == text) {
  //         // print(element.name);
  //         setState(() {
  //           if (foundServices.contains(element) == false)
  //             foundServices.add(element);
  //         });
  //       }
  //     });
  //     foundProviders = foundServices;
  //     // print(foundServices);
  //     // print(foundUserTaskLists);
  //   }
  // }
  _filterByLocations(text, texte) {
    // print(text);
    List<ServiceProvider> resultat = [];
    search.forEach((provider) {
      provider.locations.forEach((location) {
        // print(location.place['gov']);
        if (location.place['gov'] == text) {
          // print(provider.name);
          print(provider.services);
          setState(() {
            foundProviders.add(provider);
          });
        }
      });
      print(foundProviders);
      print("aaaaaaaaaaaaaa");

      foundProviders.forEach((provider) {
        provider.services.forEach((service) {
          // print(service['name']);
          if (service['name'] == texte) {
            // print(provider.name);
            print(texte);
            setState(() {
              foundServices.add(provider); //3

              print(foundProviders);
              foundProviders = foundServices;
            });
          }
        });
      });
    });
  }

  _filter() {
    if (selectedlocation.isEmpty && selectedservices.isEmpty) {
      setState(() {
        foundProviders = [];
      });
      return;
    }
    var fp = Provider.of<ProviderCalls>(context,listen: false).searchLists;
    if (selectedlocation.isNotEmpty) {
      fp = fp
          .where((element) => element.locations
              .where((e) =>
                  selectedlocation.where((s) => e.place['gov'] == s).isNotEmpty)
              .isNotEmpty)
          .toList();
      print(fp);
    }
    if (selectedservices.isNotEmpty) {
      fp = fp
          .where((element) => element.services
              .where((e) =>
                  selectedservices.where((s) => e['name'] == s).isNotEmpty)
              .isNotEmpty)
          .toList();
    }
    print(fp);
    setState(() {
      foundProviders = fp;
    });
    print(fp);
  }

}

class CustomCheckBox extends StatefulWidget {
  final String title;
  final Function onTapSelected;
  final Function onUnSelect;
  CustomCheckBox(
      {Key? key,
      required this.title,
      required this.onUnSelect,
      required this.onTapSelected})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        onTap: () {
          setState(() {
            isSelected = !isSelected;
            if (isSelected == true) {
              widget.onTapSelected();
            } else {
              widget.onUnSelect();
            }
          });
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 0),
          child: Row(
            children: <Widget>[
              Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey.withOpacity(0.6),
              ),
              const SizedBox(
                width: 4,
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  width: 120,
                  child: Text(
                    widget.title,
                    style: regularTextStyle.copyWith(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
