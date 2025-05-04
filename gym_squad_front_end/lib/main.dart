import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/screens/login_screen.dart';
import 'package:gym_squad_front_end/screens/novo_treino_screen.dart';
import 'package:gym_squad_front_end/screens/selecao_exercicio_screen.dart';
import 'package:gym_squad_front_end/screens/treino_individual_iniciado_screen.dart';
import 'package:gym_squad_front_end/screens/treinos_individuais_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: "Spartan",
        useMaterial3: true,
      ),
       routes: {
        '/': (context) => TreinosIndividuaisScreen(),
        '/treinos-individuais': (context) => TreinosIndividuaisScreen(),
        '/treino-individual-iniciado' :(context) => TreinoIndividualIniciadoScreen(),
        '/novo-treino' :(context) => NovoTreinoScreen(),
        '/add-exercicio' :(context) => SelecaoExercicioScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
