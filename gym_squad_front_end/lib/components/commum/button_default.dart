import 'package:flutter/material.dart';

class ButtonDefault extends StatefulWidget {
  const ButtonDefault({super.key, required this.funcao, required this.label});

  final Function() funcao;
  final String label;

  @override
  State<ButtonDefault> createState() => _ButtonDefaultState();
}

class _ButtonDefaultState extends State<ButtonDefault> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.funcao,
        child: Text(
          widget.label,
          style: TextStyle(
            color: Color(0xffF5FF6C),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff3F762E),
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        ),
      ),
    );
  }
}
