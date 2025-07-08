import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class TextFieldDefault extends StatefulWidget {
  const TextFieldDefault({super.key, required this.controller, required this.titulo, required this.validator, this.campoSenha, this.campoNumerico});

  final TextEditingController controller;
  final String titulo;
  final FormFieldValidator validator;
  final bool? campoSenha;
  final bool? campoNumerico;

  @override
  State<TextFieldDefault> createState() => _TextFieldDefaultState();
}

class _TextFieldDefaultState extends State<TextFieldDefault> {

  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {

    var campoSenhaWidget = widget.campoSenha ?? false;
    var campoNumericoWidget = widget.campoNumerico ?? false;

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
            keyboardType: campoNumericoWidget ? TextInputType.number : TextInputType.text,
            validator: widget.validator,
            controller: widget.controller,
            obscureText: campoSenhaWidget ? !_senhaVisivel : false,
            decoration: InputDecoration(
                fillColor: Color(ColorConstants.brancoPadrao),
                filled: true,
                
                suffixIcon: campoSenhaWidget ? IconButton(
                  icon: Icon(
                    _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _senhaVisivel = !_senhaVisivel;
                    });
                  },
                ) : null,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            
          ),
        ),
      ],
    );
  }
}
