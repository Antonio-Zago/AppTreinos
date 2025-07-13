import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/models/api/grupos/ranking_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class GrupoRankingScreen extends StatefulWidget {
  const GrupoRankingScreen({super.key});

  @override
  State<GrupoRankingScreen> createState() => _GrupoRankingScreenState();
}

class _GrupoRankingScreenState extends State<GrupoRankingScreen> {

  int? grupoId;
  int? codigo;
  bool carregouRanking = false;
  List<RankingResponse> ranking = [];
  GrupoBusiness grupoBusiness = GrupoBusiness();
  int? dropDownProvider = 0;

  Future<void> _onChangedDropDownButton(int valorSelecionado) async{
    setState(() {
        carregouRanking = false;
        dropDownProvider = valorSelecionado;
      });
      try{
        

        var response = await _retornarRankingGrupo(valorSelecionado);

        setState(() {
          carregouRanking = true;
          ranking = response;
        });
      }
      catch (e){
        setState(() {
          carregouRanking = true;
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
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    grupoId = args["grupoId"];
    codigo = args["codigo"];

    return Scaffold(
      appBar: AppBarDefault(
        title: "Ranking",
      ),
      body: BackgroundCompletoDefault(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 10, bottom: 10),
            child: Container(
              alignment: Alignment.centerRight,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: Color(ColorConstants.fundoApp),
                  value: dropDownProvider,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text(
                        "Semana",
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(ColorConstants.brancoPadrao),
                            )
                      ),
                    ),
                     DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "Mês",
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(ColorConstants.brancoPadrao),
                            )
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(
                        "Sempre",
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(ColorConstants.brancoPadrao),
                            )
                      ),
                    )
                  ], 
                  onChanged: (valorSelecionado) async{
                    await _onChangedDropDownButton(valorSelecionado!);
                  }
                ),
              ),
            ),
          ),

          Container(
            color: Color(ColorConstants.cabecalhoGrids),
            child: Row(
              children: const [
                Expanded(
                  flex: 2, 
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: Text(
                      "Nome", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(ColorConstants.brancoPadrao),
                      )
                    ),
                  )
                ),
                Expanded(
                  flex: 1, 
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(5),
                    child: Text(
                      "Qtd", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Color(ColorConstants.brancoPadrao),
                      ),
                      ),
                  )
                  ),
              ],
            ),
          ),
          !carregouRanking ?
          CircularProgressIndicatorDefault() :
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: ranking.length,
            itemBuilder: (context, index){
              
              var linhaPar = index % 2 == 0;

              return Container(
                color: linhaPar ? Color(ColorConstants.linhasGrids2) : Color(ColorConstants.linhasGrids),
                child: Row(

                        children: [
                          Expanded(
                            flex: 2,
                            child:  Padding(
                              padding: EdgeInsetsGeometry.all(5),
                              child: Text(
                                  '${ranking[index].nomeUsuario}',
                                  style: TextStyle(
                                      color: Color(ColorConstants.brancoPadrao),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                            ),                  
                          ),
                          Expanded(
                            flex: 1,
                            child:  Padding(
                              padding: EdgeInsetsGeometry.all(5),
                              child: Text(
                                  '${ranking[index].quantidade}',
                                  style: TextStyle(
                                      color: Color(ColorConstants.brancoPadrao),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                            ),                  
                          ),
                        ]
                      ),
              );
            }
          )
      ]),
    );
  }

   @override
  void initState() {
    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        carregouRanking = false;
      });
      try{
        

        var response = await _retornarRankingGrupo(0); //Semana

        setState(() {
          carregouRanking = true;
          ranking = response;
        });
      }
      catch (e){
        setState(() {
          carregouRanking = true;
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

  Future<List<RankingResponse>> _retornarRankingGrupo(int index) async{

    return await grupoBusiness.getRankingByCodigoGrupo(codigo!, index);

  }
}