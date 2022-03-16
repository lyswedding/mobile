import 'package:flutter/material.dart';

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
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
        boxShadow: [
          const BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 50,
              color: const Color(0xffEEEEEE)),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        cursorColor: const Color(0xffF5591F),
        decoration: InputDecoration(
          icon: widget.icon,
          hintText: widget.hint,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
