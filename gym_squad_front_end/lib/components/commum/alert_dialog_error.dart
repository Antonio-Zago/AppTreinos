import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';

class AlertDialogDefault extends StatefulWidget {
  const AlertDialogDefault({super.key, required this.message, required this.caminhoImagem});

  final String message;
  final String caminhoImagem;

  @override
  State<AlertDialogDefault> createState() => _AlertDialogDefaultState();
}

class _AlertDialogDefaultState extends State<AlertDialogDefault> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Image.asset(
              widget.caminhoImagem,
              width: 50,
              height: 50,
            ),
      content: Text(widget.message),
      actions: <Widget>[
        ButtonDefault(
          funcao: () {
                Navigator.of(context).pop();
              },
          label: "Fechar"
        )
      ],
    );
  }
}