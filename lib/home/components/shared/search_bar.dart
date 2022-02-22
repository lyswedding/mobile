import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/constants.dart';



class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 30),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
             // margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              //height: MediaQuery.of(context).size.height * .10,
              child: CustomInput(
                icon: Icon(Icons.search),
                hint: "search",
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              //width: 70,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.tune,
                  size: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
