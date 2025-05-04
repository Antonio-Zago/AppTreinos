import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class ButtonDefault extends StatefulWidget {
  const ButtonDefault({super.key, required this.funcao, required this.label, this.cor});

  final Function() funcao;
  final String label;
  final Color? cor;

  @override
  State<ButtonDefault> createState() => _ButtonDefaultState();
}

class _ButtonDefaultState extends State<ButtonDefault> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Opacity(
        opacity: 1.0,
        child: ElevatedButton(
          onPressed: widget.funcao,
            
          child: Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(ColorConstants.brancoPadrao),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.cor ?? Color(ColorConstants.douradoPadrao),
            
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            shape: LinearBorder.bottom()
          ),
        ),
      ),
    );
  }
}
