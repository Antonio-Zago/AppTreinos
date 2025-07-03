import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/models/api/grupos/solicitacoes_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class SolicitacoesScreen extends StatefulWidget {
  const SolicitacoesScreen({super.key});

  @override
  State<SolicitacoesScreen> createState() => _SolicitacoesScreenState();
}

class _SolicitacoesScreenState extends State<SolicitacoesScreen> {

  int? grupoId;
  bool carregouGrupos = true;
  GrupoBusiness grupoBusiness = GrupoBusiness();
  List<SolicitacoesResponse> solicitacoes = [];

  Future<List<SolicitacoesResponse>> _retornarSolicitacoesGrupo() async{

    return await grupoBusiness.getSolicitacoesByGrupoId(grupoId!);

  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    grupoId = args["grupoId"];

    return Scaffold(
      appBar: AppBarDefault(
        title: "Solicitações",
      ),
      body:BackgroundCompletoDefault(
        children: [
          !carregouGrupos ?
          CircularProgressIndicatorDefault() :
           ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: solicitacoes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(ColorConstants.linhasGrids),
                      child: ListTile(
                        title: Text(
                          '${solicitacoes[index].usuarioNome}',
                          style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children:[
                          CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Color(ColorConstants.douradoPadrao),
                                  child: IconButton(
                                      onPressed: () {
                                        
                                      },
                                      icon: Icon(Icons.done_outline),
                                      color: Color(ColorConstants.linhasGrids)),
                                ),
                          CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Color(ColorConstants.douradoPadrao),
                                  child: IconButton(
                                      onPressed: () {
                                        
                                      },
                                      icon: Icon(Icons.delete_outline),
                                      color: Color(ColorConstants.linhasGrids)),
                                ),
                        ]
                      ),
                      
                      ),
                    );
                  },
                ),
        ]
      )
    );
  }

  @override
  void initState() {
    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        carregouGrupos = false;
      });
      try{
        var response = await _retornarSolicitacoesGrupo();

        setState(() {
          carregouGrupos = true;
          solicitacoes = response;
        });
      }
      catch (e){
        setState(() {
          carregouGrupos = true;
        });
        showDialog(
          context: context, 
          builder: (BuildContext context){
            return AlertDialogDefault(
              message: e.toString(),
              caminhoImagem: "assets/images/icones/erro.png",
            );
          });
      }
      
      
    });
  }
}