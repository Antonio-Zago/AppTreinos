import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/exercicios_business.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/memoria/exercicios.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class SelecaoExercicioScreen extends StatefulWidget {
  const SelecaoExercicioScreen({super.key});

  @override
  State<SelecaoExercicioScreen> createState() => _SelecaoExercicioScreenState();
}

class _SelecaoExercicioScreenState extends State<SelecaoExercicioScreen> {

  ExerciciosBusiness exerciciosBusiness = ExerciciosBusiness();
  Exercicios? exercicios;
  bool _carregouExercicios = false;

  @override
  void initState() {
    setState(() {
      _carregouExercicios = false;
    });

    Future.delayed(Duration.zero, () async {
      await _carregarExercicios();
    });


    super.initState();
  }

  Future<void> _carregarExercicios() async {
    exercicios = await exerciciosBusiness.getAllExercicios();

    setState(() {
      _carregouExercicios = true;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundCompletoDefault(
        children: [
          _carregouExercicios ?
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: exercicios!.exercicios.length,
            itemBuilder: (context,index){
              
              final exercicio = exercicios!.exercicios[index];

              Uint8List? bytes;
              if(exercicio.foto != null && exercicio.foto != ""){
                bytes = base64Decode(exercicio.foto!);
              }
              
              

              return ListTile(
                title: Row(
                  spacing: 10,
                  children: [
                    bytes != null ?
                    Image.memory(
                      bytes,
                      width: 100,
                      height: 100,
                    )
                    :Container(),
                    Text(
                      exercicio.nome,
                      style: TextStyle(
                                  color: Color(ColorConstants.brancoPadrao),
                                  fontWeight: FontWeight.bold),
                    ),
                  ]
                ),
                onTap: () {
                    Navigator.pop(context, exercicio);
                  },
              );
            }
          ) :
          Container()
        ],
      )
      
    );
  }
}