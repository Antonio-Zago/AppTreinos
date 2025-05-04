import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

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
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
              widget.titulo,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
          child: TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
                fillColor: Color(ColorConstants.brancoPadrao),
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
