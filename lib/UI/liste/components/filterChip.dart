import 'package:flutter/material.dart';
import 'package:lys_wedding/shared/constants.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final Function onSelect;
  FilterChipWidget({Key? key, this.chipName = '', required this.onSelect})
      : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FilterChip(
        padding: const EdgeInsets.all(4.0),
        label: Text(widget.chipName),
        labelStyle:
        regularTextStyle.copyWith(color: Colors.white, fontSize: 15),
        selected: _isSelected,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: secondaryColor,
        onSelected: (isSelected) {
          setState(() {
            _isSelected = isSelected;
            widget.onSelect(isSelected);
          });
        },
        selectedColor: primaryColor,
      ),
    );
  }
}