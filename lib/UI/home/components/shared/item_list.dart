import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/search/screens/detail_search/screens/detail_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/shared/constants.dart';
import 'package:lys_wedding/shared/sharedWidgets.dart';
import 'package:lys_wedding/shared/utils.dart';

class ItemList extends StatefulWidget {
   ItemList({
    Key? key,
    required this.item,
    required this.width,
    required this.height,
    required this.isSelected
  }) : super(key: key);

  final Provider item;
  final double width, height;
  bool isSelected = false;


  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  bool isInCall = false;
  callAddToFavorite(id) async {
    await FavoriteCalls.addListToFavorite(id).then((value) {
      print(value);
      print(value.statusCode);
      if (value.statusCode == 201) {
        showToast(context: context, msg: 'Liste des tâches mise en favoris');
        setState(() {
          widget.isSelected=true;
        });
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });
    setState(() {
      isInCall = true;
    });
  }

  deleteFromFavorites(id) async {
    await FavoriteCalls.deletTaskListFromFavorite(id).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        showToast(context: context, msg: 'Liste des tâches retiré de favoris');
        setState(() {
          widget.isSelected=false;
        });
      } else {
        showToast(context: context, msg: "une erreur s'est produite!");
      }
    });
    setState(() {
      isInCall = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailSearch(provider: widget.item)));
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: EdgeInsets.only(right: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              AspectRatio(
                  aspectRatio: 1.7,
                  child: Image.network(
                    widget.item.cover,
                    fit: BoxFit.cover,
                  )),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.black12],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.item.name,
                            style: titleTextStyle.copyWith(
                                fontSize: 13, color: Colors.white),
                          )),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.item.services[0]['name'],
                            style:
                                regularTextStyle.copyWith(color: Colors.white),
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white.withOpacity(1),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(32.0),
                      ),
                      onTap: () {
                        // setState(() {
                        //   isSelected = !isSelected;
                        // });
                        if (widget.isSelected) {
                          checkIfTokenExists(() {
                            deleteFromFavorites(widget.item.id);
                          }, context);
                        } else {
                          checkIfTokenExists(() {
                            callAddToFavorite(widget.item.id);
                          }, context);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          widget.isSelected ? EvaIcons.heart : EvaIcons.heartOutline,
                          color: const Color(0xffEB5890),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // decoration: BoxDecoration(
        //   color: Colors.green,
        //    // image: DecorationImage(image: NetworkImage(item.cover,),fit: BoxFit.cover),
        //     borderRadius: const BorderRadius.all(Radius.circular(10)),),
      ),
    );
  }
}
