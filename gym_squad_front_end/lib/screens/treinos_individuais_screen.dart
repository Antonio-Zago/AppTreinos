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
    treinos = await treinosInidividuaisBusiness.getAndUpdateTreinosByUserId();

    setState(() {
      _carregouTreinos = true;
    });
  }

  Future<void> _deletarTreino(int? treinoId) async{

    

    Future.delayed(Duration.zero, () async {
      await treinosInidividuaisBusiness.deleteTreino(treinoId);
      await _atribuirTreinosUsuario();
    });
    
  } 

  Future _mostrarDialogoDeletarTreino(BuildContext context, int? treinoId) async {

    setState(() {
      _carregouTreinos = false;
    });

    return showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
          title: Text('Deseja mesmo deletar o treino?'),
          actions: [
            TextButton(
              onPressed: (){
                setState(() {
                  _carregouTreinos = true;
                });
                Navigator.of(context).pop();
              }, 
              child: Text('Não')
            ),
            TextButton(
              onPressed: () async{
                await _deletarTreino(treinoId);

                setState(() {
                  _carregouTreinos = true;
                });

                Navigator.of(context).pop();
              }, 
              child: Text('Sim')
            )
          ],
      )
    );
  }

  @override
  void initState() {

    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _carregouTreinos = false;
      });
      await _atribuirTreinosUsuario();
      setState(() {
        _carregouTreinos = true;
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "Treinos",
      ),
      drawer: DrawerDefault(),
      body: BackgroundCompletoDefault(
        children: [ !_carregouTreinos
            ? CircularProgressIndicatorDefault()
            : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: treinos == null ? 0 : treinos!.treinos.length,
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
                                    onPressed: () async {
                                      await Navigator.pushNamed(
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
                                      await _atribuirTreinosUsuario();
                                    },
                                    icon: Icon(Icons.play_arrow_outlined),
                                    color: Color(ColorConstants.linhasGrids)),
                              ),
                              CircleAvatar(
                                  backgroundColor:
                                      Color(ColorConstants.douradoPadrao),
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                        context,
                                        '/treino-individual-edit',
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
                                      icon: Icon(Icons.edit_outlined),
                                      color:
                                          Color(ColorConstants.linhasGrids))),
                              CircleAvatar(
                                  backgroundColor:
                                      Color(ColorConstants.douradoPadrao),
                                  child: IconButton(
                                      onPressed: () async{
                                        

                                        await _mostrarDialogoDeletarTreino(context,treinos!.treinos[index].treinoId);
                                      },
                                      icon: Icon(Icons.delete_outline),
                                      color:
                                          Color(ColorConstants.linhasGrids))),
                            ]),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 25, 0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child:CircleAvatar(
                      backgroundColor:Color(ColorConstants.douradoPadrao),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/novo-treino');
                        },
                        icon: Icon(Icons.add_outlined),
                        color:Color(ColorConstants.linhasGrids)
                      ),
                      radius: 25,
                    ),
                  ),
                )
                
        ]
      ),
    );
  }
}
