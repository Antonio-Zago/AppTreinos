import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/components/commum/background_camada_1_default.dart';
import 'package:gym_squad_front_end/components/commum/background_camada_2_default.dart';
import 'package:gym_squad_front_end/components/commum/background_camada_3_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';

class BackgroundCompletoDefault extends StatefulWidget {
  const BackgroundCompletoDefault({super.key, required this.children});

  final List<Widget> children;

  @override
  State<BackgroundCompletoDefault> createState() => _BackgroundCompletoDefaultState();
}

class _BackgroundCompletoDefaultState extends State<BackgroundCompletoDefault> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundCamada1Default(),
        BackgroundCamada2Default(),
        BackgroundCamada3Default(
          children: widget.children,
        ),
      ]
    );
  }
}