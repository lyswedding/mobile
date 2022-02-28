import 'package:flutter/material.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';

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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomInput(
            hint: widget.hint,
          ),
        ),
      ],
    );
  }
}
