import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/home/components/shared/item_row.dart';
import 'package:lys_wedding/home/screens/favorite/components/listsfav.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            "Search",
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
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    height: MediaQuery.of(context).size.height * .10,
                    child: CustomInput(
                      icon: Icon(Icons.search),
                      hint: "search",
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 50,
                    width: 1,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.tune,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),

            //  const CustomInput(
            //   icon: Icon(Icons.search),
            //   hint: "search",
            // ),
            // IconButton(
            //   icon: const Icon(Icons.tune),
            //   color: Colors.black,
            //   onPressed: () {},
            // ),
            const ItemRow(
              height: 100,
              color: Colors.orange,
              width: 60,
              title: "Categories",
              Image: AssetImage("images/1.jpg"),
            ),
            Row(children: const [
              Padding(padding: EdgeInsets.only(left: 16, top: 50, bottom: 10)),
              Text("Results"),
              Padding(padding: EdgeInsets.only(left: 250, top: 50, bottom: 0)),
              Text("view more")
            ]),
            Container(
              padding: const EdgeInsets.only(top: 1),
              child: const lists(
                height: 200,
                width: 200,
              ),
            )
          ]),
        ));
  }
}
