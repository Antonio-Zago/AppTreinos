import 'package:flutter/material.dart';

class DialogoDefault extends StatefulWidget {
  const DialogoDefault({super.key, required this.mensagem, required this.funcao});

  final String mensagem;
  final Function() funcao;


  @override
  State<DialogoDefault> createState() => _DialogoDefaultState();
}

class _DialogoDefaultState extends State<DialogoDefault> {
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(widget.mensagem),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Não')
            ),
            TextButton(
              onPressed: () async{
                widget.funcao();

                Navigator.of(context).pop();
              }, 
              child: Text('Sim')
            )
          ],
      );
  }
}