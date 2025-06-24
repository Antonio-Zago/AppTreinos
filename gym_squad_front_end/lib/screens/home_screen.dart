import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "GRUPOS ATUAIS",
      ),
      drawer: DrawerDefault(),
      body: BackgroundCompletoDefault(
        children: [
          Image.asset(
            "assets/images/squad-home.png",
          ),
          
          
          
        ]
      ),
    );
  }
}