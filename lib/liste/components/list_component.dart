import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lys_wedding/animation.dart';
import 'package:lys_wedding/constants.dart';
import 'package:lys_wedding/liste/components/common_card.dart';

class ListComponent extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> animation;

  const ListComponent(
      {Key? key, required this.animationController, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CommonCard(
          color: whiteColor,
          radius: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.9,
                  child: Image.asset(
                    'images/9.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Title',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                            Row(
                              children: [
                                Icon(Icons.bookmark),
                                Text(
                                  'data',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.tag_outlined),
                            Text(
                              'details',
                              // Helper.getRoomText(hotelInfo.roomData!),
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          '16 taches',
                          // Helper.getRoomText(hotelInfo.roomData!),
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
