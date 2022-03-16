import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/search/screens/filter_page.dart';
import 'package:lys_wedding/shared/constants.dart';



class SearchBar extends StatefulWidget {
  final Function? onchanged;

  const SearchBar({Key? key,this.onchanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchController=TextEditingController();
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
              child: CommonTextFieldView(
                onChanged: (String text){
                  widget.onchanged!(text);
                },
                hintText: 'search',
                controller: searchController,
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FilterPage()));
            },
            child: Expanded(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.tune,
                    size: 24,
                    color: Colors.white,
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
