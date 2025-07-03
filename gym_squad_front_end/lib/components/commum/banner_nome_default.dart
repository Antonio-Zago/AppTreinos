import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class BannerNomeDefault extends StatefulWidget {
  const BannerNomeDefault({super.key, required this.nome});

  final String nome;

  @override
  State<BannerNomeDefault> createState() => _BannerNomeDefaultState();
}

class _BannerNomeDefaultState extends State<BannerNomeDefault> {
  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
              color: Color(ColorConstants.drawerCardConta),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              widget.nome,
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          );
  }
}