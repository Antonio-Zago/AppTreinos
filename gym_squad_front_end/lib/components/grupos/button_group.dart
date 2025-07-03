import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class ButtonGroup extends StatefulWidget {
  const ButtonGroup({super.key, required this.funcao, required this.label, this.cor});

  final Function() funcao;
  final String label;
  final Color? cor;

  @override
  State<ButtonGroup> createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 10,
        child: Opacity(
          opacity: 1.0,
          child: ElevatedButton(
            onPressed: widget.funcao,
              
            child: Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(ColorConstants.brancoPadrao),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.cor ?? Color(ColorConstants.douradoPadrao),
              
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            ),
          ),
        ),
      ),
    );
  }
}