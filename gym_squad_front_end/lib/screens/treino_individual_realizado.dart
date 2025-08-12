import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/banner_nome_default.dart';
import 'package:gym_squad_front_end/models/memoria/treino_finalizado.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class TreinoIndividualRealizado extends StatefulWidget {
  const TreinoIndividualRealizado({super.key});

  @override
  State<TreinoIndividualRealizado> createState() => _TreinoIndividualRealizadoState();
}

class _TreinoIndividualRealizadoState extends State<TreinoIndividualRealizado> {

  TreinoFinalizado? treinoFinalizado;

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    treinoFinalizado = args["treinoRealizado"];

    return Scaffold(
      appBar: AppBarDefault(
        title: treinoFinalizado!.nomeTreino!,
      ),
      body: BackgroundCompletoDefault(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: treinoFinalizado!.exercicios!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                color: Color(ColorConstants.linhasGrids),
                child: ListTile(
                    title: Text(
                      treinoFinalizado!.exercicios![index].exercicioNome!,
                      style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xff4D4D4D),
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,  
                        itemCount: treinoFinalizado!.exercicios![index].dadosTreinoExercicioSeries!.length,
                        itemBuilder: (context, indexSeries) {
                          return ListTile(
                            title: Row(
                              spacing: 10,
                              children: [
                                Text(
                                  "Reps",
                                  style: TextStyle(
                                    color: Color(ColorConstants.brancoPadrao),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: new Border.all(
                                        color: Color(ColorConstants.brancoPadrao),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Text(
                                      treinoFinalizado!.exercicios![index].dadosTreinoExercicioSeries![indexSeries].repeticoes.toString(),
                                      style: TextStyle(
                                        color: Color(ColorConstants.brancoPadrao),
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Carga",
                                  style: TextStyle(
                                    color: Color(ColorConstants.brancoPadrao),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: new Border.all(
                                        color: Color(ColorConstants.brancoPadrao),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Text(
                                      treinoFinalizado!.exercicios![index].dadosTreinoExercicioSeries![indexSeries].carga.toString(),
                                      style: TextStyle(
                                        color: Color(ColorConstants.brancoPadrao),
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    )
                )
              );
            },
          ),
        ]
        ),
      
    );
  }
}