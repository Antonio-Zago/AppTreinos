import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class CircularProgressIndicatorDefault extends StatefulWidget {
  const CircularProgressIndicatorDefault({super.key});

  @override
  State<CircularProgressIndicatorDefault> createState() => _CircularProgressIndicatorDefaultState();
}

class _CircularProgressIndicatorDefaultState extends State<CircularProgressIndicatorDefault> {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Color(ColorConstants.verdeEscuroPadrao),
    );
  }
}