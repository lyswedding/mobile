import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/search/screens/detail_search/screens/detail_search.dart';
import 'package:lys_wedding/models/List_search.dart';
import 'package:lys_wedding/models/service.dart';
import 'package:lys_wedding/shared/constants.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
   required this.item,
    required this.width,
    required this.height,
  }) : super(key: key);

 final Provider item;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return  Container(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
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
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.favorite_border_rounded,
                                  color: Color(0xffEB5890),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  item.name,
                                  style:
                                      titleTextStyle.copyWith(fontSize: 15,color: Colors.white),
                                )),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  item.services[0]['name'],
                                  style:regularTextStyle.copyWith(color: Colors.white),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                      image: DecorationImage(image: NetworkImage(item.cover,),fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),),
                );
  }
}
