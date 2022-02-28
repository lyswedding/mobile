import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/search/components/common_appbar_view.dart';
import 'package:lys_wedding/UI/search/components/slider_view.dart';
import 'package:lys_wedding/shared/constants.dart';


class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

List<String> popularFilterListData=[
  'service 1',
  'service 1',
  'service 1',
  'service 1',
  'service 1',
  'service 1',
  'service 1',
  'service 1',
];

List<String> GovernoratFilterListData=[
  'tunis',
  'nabeul',
  'bizerte',
  'kef',
  'zaghouen',
  'manouba',
  'ariana'
];
double distValue = 50.0;
bool isSelected = false;

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBGColor,
      body: Scaffold(
        // backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonAppbarView(
              iconData: Icons.close,
              onBackClick: () {
                Navigator.pop(context);
              },
              titleText: "filter",
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
                    margin: const EdgeInsets.only(left: 20, right: 20,),
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
                      onPressed: () {},
                      child: const Text(
                        "appliquer filtre",
                        style: TextStyle(fontSize: 18),
                      ),
                    )),
              ),
            ),
          ],
        ),
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
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
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
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
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
    for (var i = 0; i < popularFilterListData.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = popularFilterListData[cout];
          listUI.add(
            Expanded(
              child: Row(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8, bottom: 8, right: 0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                date,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          cout += 1;
        } catch (e) {
        }
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
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
                      onTap: () {
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8, bottom: 8, right: 0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              isSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                date,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          cout += 1;
        } catch (e) {
        }
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

}
