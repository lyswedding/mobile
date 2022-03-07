import 'package:flutter/material.dart';
import 'package:lys_wedding/shared/constants.dart';

class CustomInput extends StatefulWidget {
  final icon;
  final hint;
  final controller;
  const CustomInput({this.icon, this.hint, this.controller});

  @override
  CustomInputState createState() => CustomInputState();
}

class CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        alignment: Alignment.center,
        // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
         padding: const EdgeInsets.only(left: 20, right: 20),

        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        child: TextField(
          controller: widget.controller,
          cursorColor: const Color(0xffF5591F),
          decoration: InputDecoration(
            icon: widget.icon,
            hintText: widget.hint,
            hintStyle: regularTextStyle,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
