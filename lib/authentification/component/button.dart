import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/screens/signup.dart';

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
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          widget.onPressed();
        });
  }
}
