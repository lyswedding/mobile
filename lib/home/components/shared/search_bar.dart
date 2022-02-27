import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/search/screens/filter_page.dart';



class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Container(
             // margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              //height: MediaQuery.of(context).size.height * .10,
              child: const CustomInput(
                icon: Icon(Icons.search),
                hint: "search",
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterPage()));
            },
            child: Expanded(
              child: Container(
                height: 50,
                //width: 70,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.tune,
                    size: 24,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
