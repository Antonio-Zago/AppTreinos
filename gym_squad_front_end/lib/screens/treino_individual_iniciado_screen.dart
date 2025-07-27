import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/treinos_inidividuais_business.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class TreinoIndividualIniciadoScreen extends StatefulWidget {
  const TreinoIndividualIniciadoScreen({super.key});

  @override
  State<TreinoIndividualIniciadoScreen> createState() =>
      _TreinoIndividualIniciadoScreenState();
}

class _TreinoIndividualIniciadoScreenState
    extends State<TreinoIndividualIniciadoScreen> {
  TreinosInidividuaisBusiness treinosInidividuaisBusiness =
      TreinosInidividuaisBusiness();
  Color? corLinha;
  Map<String, TextEditingController> listControllersReps = {};
  Map<String, TextEditingController> listControllersCarga = {};
  Map<String, bool> listSerieConcluidaController = {};
  bool carregando = false;
  String nomeTreino = "";

  Future _mostrarDialogo(BuildContext context, int treinoId, List<TreinoExerciciosResponse> exercicios) async {
    
    return showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context){

          bool _desabilitado = false;

          return StatefulBuilder(
             builder: (context, setStateDialog){
              return AlertDialog(
                title: Text('Deseja finalizar o treino?'),
                content: _desabilitado
                ? const SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : null,
                actions: [
                  TextButton(
                    onPressed: _desabilitado ? null :(){
                      setState(() {
                        carregando = false;
                      });
                      setStateDialog(() => _desabilitado = true);
                      Navigator.pop(context);
                    }, 
                    child:  Text('Não'),
                  ),
                  TextButton(
                    onPressed: _desabilitado ? null : () async{
                      setStateDialog(() => _desabilitado = true);
                      await _finalizarTreino(treinoId, exercicios);
                      if (!context.mounted) return;
                    }, 
                    child: Text('Sim'),
                  )
                ],
                      );
             }
          );
        }
      );

    
  }
  

  Future _finalizarTreino(int treinoId, List<TreinoExerciciosResponse> exercicios) async {

    List<ExercicioIniciadoRequest> exerciciosRequest = [];

    List<SerieIniciadoRequest> seriesRequest = [];

    bool teveAlteracaoCargaReps = false;

    var contadorExercicio = 0;

    for(var exercicio in exercicios){
      var exercicioId = exercicio.id;
      
      for(var contadorSerie = 0; contadorSerie < listControllersReps.length; contadorSerie++){
        var reps = listControllersReps["$exercicioId-$contadorExercicio-$contadorSerie"];

        var carga = listControllersCarga["$exercicioId-$contadorExercicio-$contadorSerie"];

        //Encontrou os controllers de carga e repetições
        if(reps != null && carga != null){
          var serieRequest = SerieIniciadoRequest(int.parse( reps.text), double.parse(carga.text));

          seriesRequest.add(serieRequest);
        }

      }

      var exercicioRequest = ExercicioIniciadoRequest(exercicioId!,List.from(seriesRequest));

      exerciciosRequest.add(exercicioRequest);

      seriesRequest.clear();

      contadorExercicio ++;
    }
    var treinoIniciadoDispositivo = await treinosInidividuaisBusiness.getTreinosByUserIdAndTreinoId(treinoId);

    var treinoFinalizado = await treinosInidividuaisBusiness.postTreinoFinalizado(exerciciosRequest, treinoId, nomeTreino);

    
    List<TreinoExerciciosRequest> listaExerciciosRequest = [];

    for(var exercicio in treinoFinalizado.exercicios){

      List<SerieRequest> listaSeriesRequest = [];

      var exercicioIniciadoDispositivo = treinoIniciadoDispositivo!.exercicios.firstWhere((exercicioDispositivo)=> exercicioDispositivo.id! == exercicio.exercicioId);

      for(int i =0;i<exercicio.dadosTreinoExercicioSeries.length;i++){

        var serieIniciadaRequest = exercicioIniciadoDispositivo.series[i];

        if(!teveAlteracaoCargaReps){
          teveAlteracaoCargaReps = serieIniciadaRequest.carga != exercicio.dadosTreinoExercicioSeries[i].carga ||
                                 serieIniciadaRequest.repeticoes != exercicio.dadosTreinoExercicioSeries[i].repeticoes;
        }
        
        var serieRequest = SerieRequest(exercicio.dadosTreinoExercicioSeries[i].repeticoes, exercicio.dadosTreinoExercicioSeries[i].carga);

        listaSeriesRequest.add(serieRequest);
      }

      var treinoRequest= TreinoExerciciosRequest(exercicio.exercicioId,listaSeriesRequest, null, null);

      listaExerciciosRequest.add(treinoRequest);
    }
        
    if(teveAlteracaoCargaReps){
      if (context.mounted) {
        return showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context){

          bool _desabilitado = false;

          return StatefulBuilder(
             builder: (context, setStateDialog){
              return AlertDialog(
                title: Text('Deseja salvar as alterações do treino?'),
                content: _desabilitado
                ? const SizedBox(
                    height: 40,
                    width: 40,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : null,
                actions: [
                  TextButton(
                    onPressed: _desabilitado ? null :(){
                      setState(() {
                        carregando = false;
                      });
                      setStateDialog(() => _desabilitado = true);
                      Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                        '/treino-individual-iniciado-publicacao',
                                                        ModalRoute.withName('/treinos-individuais'),
                                                      );
                    }, 
                    child:  Text('Não'),
                  ),
                  TextButton(
                    onPressed: _desabilitado ? null : () async{
                      setStateDialog(() => _desabilitado = true);
                      await treinosInidividuaisBusiness.postTreino(listaExerciciosRequest, nomeTreino, treinoId, false);
                      Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                        '/treino-individual-iniciado-publicacao',
                                                        ModalRoute.withName('/treinos-individuais'),
                                                      );
                    }, 
                    child: Text('Sim'),
                  )
                ],
                      );
             }
          );
        }
      );

        
      }
    }
    else{
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
                                              context,
                                                      '/treino-individual-iniciado-publicacao',
                                                      ModalRoute.withName('/treinos-individuais'),
                                                    );
      };
    }
  }

  _iniciarVariaveis(List<TreinoExerciciosResponse> exercicios) {
    var contadorExercicio = 0;
    var contadorSerie = 0;

    for (var exercicio in exercicios) {
      var exercicioId = exercicio.id;
      contadorSerie = 0;
      for (var serie in exercicio.series) {
        TextEditingController textEditingControllerRep =
            TextEditingController();
        textEditingControllerRep.text = serie.repeticoes.toString();
        TextEditingController textEditingControllerCarga =
            TextEditingController();
        textEditingControllerCarga.text = serie.carga.toString();

        listControllersReps["$exercicioId-$contadorExercicio-$contadorSerie"] =
            textEditingControllerRep;
        listControllersCarga["$exercicioId-$contadorExercicio-$contadorSerie"] =
            textEditingControllerCarga;

        if (listSerieConcluidaController.isEmpty ||
            listSerieConcluidaController["$exercicioId-$contadorExercicio-$contadorSerie"] ==
                null) {
          listSerieConcluidaController["$exercicioId-$contadorExercicio-$contadorSerie"] =
              false;
        }

        contadorSerie += 1;
      }
      contadorExercicio += 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    nomeTreino = args["nomeTreino"];

    List<TreinoExerciciosResponse> exercicios = args["exercicios"];
    var treinoId = args["treinoId"];
    // Por causa disso que não atualiza

    if(listControllersReps.isEmpty ){
      _iniciarVariaveis(exercicios);
    }
    

    return Scaffold(
      appBar: AppBarDefault(
        title: nomeTreino,
      ),
      body: BackgroundCompletoDefault(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                color: Color(ColorConstants.linhasGrids),
                child: ListTile(
                    title: Text(
                      exercicios[index].nome,
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
                          
                          itemCount: exercicios[index].series.length,
                          itemBuilder: (context, indexSeries) {

                            var exercicioId = exercicios[index].id;

                            return CheckboxListTile(
                              
                              side: BorderSide(
                                color: Color(ColorConstants.brancoPadrao)
                              ),
                              activeColor: Colors.green,
                              value: listSerieConcluidaController[
                                  '$exercicioId-$index-$indexSeries'],
                              //activeColor: Colors.green,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Row(spacing: 10, children: [
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
                                      color:   listSerieConcluidaController[
                                  '$exercicioId-$index-$indexSeries']! ? Color(ColorConstants.cinzaInputDesabilitado) : null,
                                      border: new Border.all(
                                        color: Color(ColorConstants.brancoPadrao),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Opacity(
                                      opacity: listSerieConcluidaController[
                                  '$exercicioId-$index-$indexSeries']! ? 0.5 : 1.0,
                                      child: TextField(
                                        enabled: ! listSerieConcluidaController[
                                  '$exercicioId-$index-$indexSeries']!,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                      
                                        ),
                                        controller: listControllersReps[
                                            '$exercicioId-$index-$indexSeries'],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(ColorConstants.brancoPadrao),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
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
                                       color:   listSerieConcluidaController[
                                  '$exercicioId-$index-$indexSeries']! ? Color(ColorConstants.cinzaInputDesabilitado) : null,
                                      border: new Border.all(
                                        color: Color(ColorConstants.brancoPadrao),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Opacity(
                                      opacity: listSerieConcluidaController[
                                  '$exercicioId-$index-$indexSeries']! ? 0.5 : 1.0,
                                      child: TextField(
                                        enabled: ! listSerieConcluidaController[
                                                                        '$exercicioId-$index-$indexSeries']!,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        controller: listControllersCarga[
                                            '$exercicioId-$index-$indexSeries'],
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(ColorConstants.brancoPadrao),
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              onChanged: (bool? value) {
                                setState(() {
                                  listControllersReps['$exercicioId-$index-$indexSeries'];

                                  listSerieConcluidaController[
                                          '$exercicioId-$index-$indexSeries'] =
                                      !listSerieConcluidaController[
                                          '$exercicioId-$index-$indexSeries']!;
                                });
                              },
                            );
                          }),
                    )),
              );
            },
          ),
          carregando ?
          CircularProgressIndicator()
          :
          ButtonDefault(funcao: () async{
            setState(() {
              carregando = true;
            });

            await _mostrarDialogo(context,treinoId, exercicios );

            //if (!context.mounted) return;     

            //await _mostrarDialogoPublicacao(context);

          }, 
          label: "Terminar treino")
        ]
        ),
      
    );
  }
}
