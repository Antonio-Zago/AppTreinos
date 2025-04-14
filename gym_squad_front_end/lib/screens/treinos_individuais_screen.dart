import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/treinos_inidividuais_business.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_camada_1_default.dart';
import 'package:gym_squad_front_end/components/commum/background_camada_2_default.dart';
import 'package:gym_squad_front_end/components/commum/background_camada_3_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class TreinosIndividuaisScreen extends StatefulWidget {
  const TreinosIndividuaisScreen({super.key});

  @override
  State<TreinosIndividuaisScreen> createState() =>
      _TreinosIndividuaisScreenState();
}

class _TreinosIndividuaisScreenState extends State<TreinosIndividuaisScreen> {
  TreinosInidividuaisBusiness treinosInidividuaisBusiness =
      TreinosInidividuaisBusiness();
  UsuarioTreinos? treinos;
  bool _carregouTreinos = false;
  Color? corLinha;

  Future<void> _atribuirTreinosUsuario() async {
    treinos = await treinosInidividuaisBusiness.getTreinosByUserId();

    setState(() {
      _carregouTreinos = true;
    });
  }

  @override
  void initState() {
    setState(() {
      _carregouTreinos = false;
    });

    Future.delayed(Duration.zero, () async {
      await _atribuirTreinosUsuario();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "TREINO INDIVIDUAL",
      ),
      drawer: DrawerDefault(),
      body: BackgroundCompletoDefault(
        children: [ !_carregouTreinos
            ? CircularProgressIndicatorDefault()
            : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: treinos!.treinos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(ColorConstants.linhasGrids),
                      child: ListTile(
                        title: Text(
                          '${treinos!.treinos[index]!.nomeTreino}',
                          style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 5,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color(ColorConstants.douradoPadrao),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/treino-individual-iniciado',
                                        arguments: <String, dynamic>{
                                          'exercicios': treinos!
                                              .treinos[index].exercicios,
                                          'nomeTreino': treinos!
                                              .treinos[index].nomeTreino,
                                          'treinoId': treinos!
                                              .treinos[index].treinoId,
                                        },
                                      );
                                    },
                                    icon: Icon(Icons.play_arrow_rounded),
                                    color: Color(ColorConstants.linhasGrids)),
                              ),
                              CircleAvatar(
                                  backgroundColor:
                                      Color(ColorConstants.douradoPadrao),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                      color:
                                          Color(ColorConstants.linhasGrids))),
                            ]),
                      ),
                    );
                  },
                ),
        ]
      ),
    );
  }
}
