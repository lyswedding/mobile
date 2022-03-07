import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/shared/constants.dart';

class AddListInput extends StatefulWidget {
  final String titre;
  final String hint;
  final TextEditingController textEditingController;

   AddListInput({
    Key? key,
    required this.titre,
    required this.hint,
     required this.textEditingController,

  }) : super(key: key);

  @override
  _AddListInputState createState() => _AddListInputState();
}

class _AddListInputState extends State<AddListInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.titre,style: titleTextStyle.copyWith(fontSize: 14),),
          SizedBox(height: 10,),
          // CustomInput(
          //   hint: widget.hint,
          //   controller: widget.textEditingController,
          // ),
        ],
      ),
    );
  }
}
