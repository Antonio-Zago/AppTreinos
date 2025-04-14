import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class BackgroundCamada1Default extends StatelessWidget {
  const BackgroundCamada1Default({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color(ColorConstants.fundoApp),
            )
          );
  }
}