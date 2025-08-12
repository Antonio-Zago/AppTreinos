import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym_squad_front_end/business/auth_service.dart';
import 'package:gym_squad_front_end/screens/calendario_treinos_screen.dart';
import 'package:gym_squad_front_end/screens/grupo_busca_screen.dart';
import 'package:gym_squad_front_end/screens/grupo_novo_screen.dart';
import 'package:gym_squad_front_end/screens/grupo_ranking_screen.dart';
import 'package:gym_squad_front_end/screens/grupo_screen.dart';
import 'package:gym_squad_front_end/screens/home_screen.dart';
import 'package:gym_squad_front_end/screens/integrantes_screen.dart';
import 'package:gym_squad_front_end/screens/login_screen.dart';
import 'package:gym_squad_front_end/screens/novo_treino_screen.dart';
import 'package:gym_squad_front_end/screens/register_screen.dart';
import 'package:gym_squad_front_end/screens/selecao_exercicio_screen.dart';
import 'package:gym_squad_front_end/screens/solicitacoes_screen.dart';
import 'package:gym_squad_front_end/screens/splash_screen.dart';
import 'package:gym_squad_front_end/screens/treino_individual_edit_screen.dart';
import 'package:gym_squad_front_end/screens/treino_individual_iniciado_publicacao_screen.dart';
import 'package:gym_squad_front_end/screens/treino_individual_iniciado_screen.dart';
import 'package:gym_squad_front_end/screens/treino_individual_realizado.dart';
import 'package:gym_squad_front_end/screens/treinos_individuais_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  Animate.restartOnHotReload = true;
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
        '/': (context) => SplashScreen(),
        '/login' : (context) => LoginScreen(),
        '/treinos-individuais': (context) => TreinosIndividuaisScreen(),
        '/treino-individual-iniciado' :(context) => TreinoIndividualIniciadoScreen(),
        '/treino-individual-edit' :(context) => TreinoIndividualEditScreen(),
        '/novo-treino' :(context) => NovoTreinoScreen(),
        '/add-exercicio' :(context) => SelecaoExercicioScreen(),
        '/registro-usuario' :(context) => RegisterScreen(),
        '/home' :(context) => HomeScreen(),
        '/grupo' :(context) => GrupoScreen(),
        '/grupo-integrantes' :(context) => IntegrantesScreen(),
        '/grupo-solicitacoes' :(context) => SolicitacoesScreen(),
        '/grupo-novo' :(context) => GrupoNovoScreen(),
        '/grupo-busca' :(context) => GrupoBuscaScreen(),
        '/grupo-ranking' :(context) => GrupoRankingScreen(),
        '/treino-individual-iniciado-publicacao' :(context) => TreinoIndividualIniciadoPublicacaoScreen(),
        '/calendario-treinos' :(context) => CalendarioTreinosScreen(),
        '/treino-individual-realizado' :(context) => TreinoIndividualRealizado(),
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: AuthService().navigatorKey,
      localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate, 
          ],
          supportedLocales: [
            const Locale('en', ''), // English
            const Locale('pt', 'BR'), // Brazilian Portuguese
            // Add other supported locales as needed
          ],
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
