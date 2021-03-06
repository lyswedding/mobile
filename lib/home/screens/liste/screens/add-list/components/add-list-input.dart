import 'package:flutter/material.dart';
import 'package:lys_wedding/authentification/components/custom_input.dart';

class AddListInput extends StatefulWidget {
  final String titre;
  final String hint;

  const AddListInput({
    Key? key,
    required this.titre,
    required this.hint,
  }) : super(key: key);

  @override
  _AddListInputState createState() => _AddListInputState();
}

class _AddListInputState extends State<AddListInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 25)),
            Text(
              widget.titre,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        CustomInput(
          hint: widget.hint,
        ),
      ],
    );
  }
}
