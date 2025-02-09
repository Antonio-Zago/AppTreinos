import 'package:flutter/material.dart';

class TextFieldDefault extends StatefulWidget {
  const TextFieldDefault({super.key, required this.controller, required this.titulo, required this.validator});

  final TextEditingController controller;
  final String titulo;
  final FormFieldValidator validator;

  @override
  State<TextFieldDefault> createState() => _TextFieldDefaultState();
}

class _TextFieldDefaultState extends State<TextFieldDefault> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            widget.titulo,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
                fillColor: Color(0xffDCFFD1),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
          ),
        ),
      ],
    );
  }
}
