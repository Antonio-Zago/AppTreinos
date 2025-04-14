import 'package:flutter/material.dart';

class BackgroundCamada2Default extends StatelessWidget {
  const BackgroundCamada2Default({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain, // Ajusta a imagem para cobrir toda a tela
                ),
            ),
          );
  }
}