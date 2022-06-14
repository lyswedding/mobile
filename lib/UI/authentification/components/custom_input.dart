import 'package:flutter/material.dart';
import 'package:lys_wedding/shared/constants.dart';

class CommonTextFieldView extends StatefulWidget {
  final String? titleText;
  final String hintText;
  final String? errorText;
  final bool isObscureText, isAllowTopTitleView;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool enabled;

  const CommonTextFieldView({
    Key? key,
    this.hintText = '',
    this.isObscureText = false,
    this.padding = const EdgeInsets.only(),
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isAllowTopTitleView = true,
    this.errorText,
    this.titleText = '',
    this.controller,
    this.focusNode,
    this.enabled = true,
  }) : super(key: key);
  @override
  State<CommonTextFieldView> createState() => _CommonTextFieldViewState();
}

class _CommonTextFieldViewState extends State<CommonTextFieldView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        alignment: Alignment.center,
        // margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: const EdgeInsets.only(left: 20, right: 20),

        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        child: TextField(
          enabled: widget.enabled,
          controller: widget.controller,
          maxLines: 1,
          onChanged: widget.onChanged,
          style: regularTextStyle.copyWith(fontSize: 15, color: primaryColor),
          focusNode: widget.focusNode,
          obscureText: widget.isObscureText,
          cursorColor: Theme.of(context).primaryColor,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          decoration: InputDecoration(
            errorText: null,
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Theme.of(context).disabledColor),
          ),
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}
