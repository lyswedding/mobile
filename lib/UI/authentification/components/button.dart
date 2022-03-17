import 'package:flutter/material.dart';
import 'package:lys_wedding/shared/constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  const CustomButton({required this.text, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: primaryColor,
            ),
            child: Center(
              child: Text(
                widget.text,
                style: btnTextStyle.copyWith(color: whiteColor,),
              ),
            ),
          ),
        ),
        onTap: () {
          widget.onPressed();
        });
  }
}
