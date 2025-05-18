import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/treinos_inidividuais_business.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class TreinoIndividualEditScreen extends StatefulWidget {
  const TreinoIndividualEditScreen({super.key});

  @override
  State<TreinoIndividualEditScreen> createState() =>
      _TreinoIndividualEditScreenState();
}

class _TreinoIndividualEditScreenState
    extends State<TreinoIndividualEditScreen> {
  TreinosInidividuaisBusiness treinosInidividuaisBusiness =
      TreinosInidividuaisBusiness();
  Color? corLinha;
  Map<String, TextEditingController> listControllersReps = {};
  Map<String, TextEditingController> listControllersCarga = {};
  bool carregando = false;
  List<TreinoExerciciosRequest> exercicios = [];

  Future _mostrarDialogo(BuildContext context, int treinoId, List<TreinoExerciciosRequest> exercicios, String nomeTreino) async {

    setState(() {
      carregando = true;
    });

    return showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
          title: Text('Deseja salvar as alterações do treino?'),
          actions: [
            TextButton(
              onPressed: (){
                setState(() {
                  carregando = false;
                });
                Navigator.of(context).pop();
              }, 
              child: Text('Não')
            ),
            TextButton(
              onPressed: () async{
                await _salvarTreino(treinoId, exercicios, nomeTreino);
                setState(() {
                  carregando = false;
                });
                Navigator.pushReplacementNamed(
                                        context,
                                        '/treinos-individuais',
                                      );
              }, 
              child: Text('Sim')
            )
          ],
      )
    );
  }

  Future _salvarTreino(int treinoId, List<TreinoExerciciosRequest> exercicios, String nomeTreino) async {

    await treinosInidividuaisBusiness.postTreino(exercicios, nomeTreino, treinoId);

  }

  void _selecionarExericio() async {
    final result = await Navigator.pushNamed(context, '/add-exercicio');
    if (result != null && result is ExercicioResponse) {
      ExercicioResponse exercicioSelecionado = result;

      TreinoExerciciosRequest treinoExerciciosRequest = TreinoExerciciosRequest(
          exercicioSelecionado.id,
          [],
          exercicioSelecionado.foto,
          exercicioSelecionado.nome);
      setState(() {
        exercicios.add(treinoExerciciosRequest);
      });
    }
  }

   void _adicionarSerie(int indexExercicio) {
    SerieRequest serieRequest = SerieRequest(0, 0);

    setState(() {
      exercicios[indexExercicio].series.add(serieRequest);
    });
  }

  void _carregarExercicios(List<TreinoExerciciosResponse> exerciciosResponse){

    List<TreinoExerciciosRequest> treinosExerciciosRequest = [];
    for(var exercicioResponse in exerciciosResponse){
      List<SerieRequest> seriesRequest = [];
      for(var seriesResponse in exercicioResponse.series){
        TextEditingController controllerCarga = TextEditingController();
        TextEditingController controllerReps = TextEditingController();
        controllerCarga.text = seriesResponse.carga.toString();
        controllerReps.text = seriesResponse.repeticoes.toString();
        SerieRequest serieRequest = SerieRequest(seriesResponse.repeticoes,seriesResponse.carga,controllerCarga: controllerCarga, controllerReps: controllerReps);
        seriesRequest.add(serieRequest);
      }

      TreinoExerciciosRequest treinoExerciciosRequest = TreinoExerciciosRequest(exercicioResponse.id!, seriesRequest, exercicioResponse.foto, exercicioResponse.nome);
      treinosExerciciosRequest.add(treinoExerciciosRequest);
    }

    exercicios = treinosExerciciosRequest;
  }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List<TreinoExerciciosResponse> exerciciosRespose = args["exercicios"];

    if(exercicios.isEmpty){
       _carregarExercicios(exerciciosRespose);
    }
   
    final _formKey = GlobalKey<FormState>();
    TextEditingController nomeController = TextEditingController();

    nomeController.text = args["nomeTreino"];
    var treinoId = args["treinoId"];
    

    return Scaffold(
      appBar: AppBarDefault(
        title: args["nomeTreino"],
      ),
      body: BackgroundCompletoDefault(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldDefault(
                  controller: nomeController,
                  titulo: "NOME",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Informe o nome do treino';
                    }
                  },
                ),
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
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                exercicios[index].nome!,
                                style: TextStyle(
                                        color: Color(ColorConstants.brancoPadrao),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: CircleAvatar(
                                    backgroundColor:
                                        Color(ColorConstants.vermelhoPadrao),
                                    child: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            exercicios.removeAt(index);
                                        });
                                        },
                                        icon: Icon(Icons.delete),
                                        color:
                                            Color(ColorConstants.linhasGrids))),
                              ),
                            ]
                          ),
                          subtitle: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color(0xff4D4D4D),
                            ),
                            child: Column(
                              children:[
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    
                                    itemCount: exercicios[index].series.length,
                                    itemBuilder: (context, indexSeries) {
                                              
                                                
                                      return ListTile(
                                        
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
                                                border: new Border.all(
                                                  color: Color(ColorConstants.brancoPadrao),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                              
                                                ),
                                                controller: exercicios[index].series[indexSeries].controllerReps,
                                                onChanged: (value) => {
                                                  if(value.isNotEmpty){
                                                    exercicios[index]
                                                      .series[indexSeries]
                                                      .repeticoes = int.parse(value)
                                                  }
                                                  
                                                },
                                                keyboardType: TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(ColorConstants.brancoPadrao),
                                                  fontWeight: FontWeight.bold
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
                                                border: new Border.all(
                                                  color: Color(ColorConstants.brancoPadrao),
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: TextFormField(
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                controller: exercicios[index].series[indexSeries].controllerCarga,
                                                onChanged: (value) => {
                                                  if(value.isNotEmpty){
                                                    exercicios[index]
                                                        .series[indexSeries]
                                                        .carga = double.parse(value)
                                                  }
                                                },
                                                keyboardType: TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(ColorConstants.brancoPadrao),
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),
                                          CircleAvatar(
                                  backgroundColor:
                                      Color(ColorConstants.vermelhoPadrao),
                                  child: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          exercicios[index].series.removeAt(indexSeries);
                                        });
                                      },
                                      icon: Icon(Icons.delete),
                                      color:
                                          Color(ColorConstants.linhasGrids))),
                                        ]),
                                      );
                                    }),
                                    ButtonDefault(
                                      funcao: () {
                                        _adicionarSerie(index);
                                      },
                                      label: "Adicionar série",
                                      cor: Color(ColorConstants.azulEscuroPadrao),
                                    )
                                        ]
                                      ),  
                          )),
                    );
                  },
                ),
                
              ]
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: carregando
                  ? CircularProgressIndicator()
                  : ButtonDefault(
                      funcao: () {
                        _selecionarExericio();
                      },
                      label: "Adicionar exercício",
                    ),
            ),
          carregando ?
          CircularProgressIndicator()
          :
          ButtonDefault(
            funcao: () async{
            await _mostrarDialogo(context,treinoId, exercicios, nomeController.text );
          }, 
          label: "Salvar treino",
          cor: Color(ColorConstants.verdeEscuroPadrao),
          )
        ]
        ),
      
    );
  }
}
