import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/exercicios_business.dart';
import 'package:gym_squad_front_end/business/treinos_inidividuais_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_request.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class NovoTreinoScreen extends StatefulWidget {
  const NovoTreinoScreen({super.key});

  @override
  State<NovoTreinoScreen> createState() => _NovoTreinoScreenState();
}

class _NovoTreinoScreenState extends State<NovoTreinoScreen> {
  TextEditingController nomeController = TextEditingController();
  List<TreinoExerciciosRequest> exerciciosRequest = [];
  TreinosInidividuaisBusiness treinosInidividuaisBusiness =
      TreinosInidividuaisBusiness();
  bool carregando = false;
  final _formKey = GlobalKey<FormState>();

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
        exerciciosRequest.add(treinoExerciciosRequest);
      });
    }
  }

  void _adicionarSerie(int indexExercicio) {
    SerieRequest serieRequest = SerieRequest(0, 0);

    setState(() {
      exerciciosRequest[indexExercicio].series.add(serieRequest);
    });
  }

  Future _salvarTreino() async {
    setState(() {
      carregando = true;
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        carregando = false;
      });
      return;
    } 

    if(exerciciosRequest.isEmpty){
      await _mostrarDialogoErro("Necessário ter ao menos um exercicio cadastrado no treino");
      setState(() {
        carregando = false;
      });
      return;
    }
    else{
      for(var exercicioRequest in exerciciosRequest){
        if(exercicioRequest.series.isEmpty){
          await _mostrarDialogoErro("Necessário ter ao menos uma séria cadastrada em cada exercicio");
          setState(() {
            carregando = false;
          });
          return;
        }   
      }
    }

    await treinosInidividuaisBusiness.postTreinoNovo(
        exerciciosRequest, nomeController.text);

    setState(() {
      carregando = false;
    });

    await _mostrarDialogo();

    Navigator.pushReplacementNamed(
      context,
      '/treinos-individuais',
    );
  }

  Future _mostrarDialogo() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialogDefault(
              message: "Treino cadastrado com sucesso!",
              caminhoImagem: "assets/images/icones/ok.png",
            ));
  }

  Future _mostrarDialogoErro(String mensagem) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialogDefault(
              message: mensagem,
              caminhoImagem: "assets/images/icones/erro.png",
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "NOVO TREINO",
      ),
      body: BackgroundCompletoDefault(children: [
        Form(
          key: _formKey,
          child: Column(children: [
            TextFieldDefault(
              controller: nomeController,
              titulo: "NOME",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o nome do treino';
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: exerciciosRequest.length,
                  itemBuilder: (context, index) {
                    final exercicio = exerciciosRequest[index];
                    Uint8List? bytes;
                    if (exercicio.foto != null && exercicio.foto != "") {
                      bytes = base64Decode(exercicio.foto!);
                    }

                    return ListTile(
                      title: Row(spacing: 10, children: [
                        bytes != null
                            ? Image.memory(
                                bytes,
                                width: 100,
                                height: 100,
                              )
                            : Container(),
                        Text(
                          exercicio.nome!,
                          style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                      subtitle: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xff4D4D4D),
                        ),
                        child: Column(children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: exerciciosRequest[index].series.length,
                              itemBuilder: (context, indexSerie) {
                                return ListTile(
                                  title: Row(
                                    spacing: 10,
                                    children: [
                                      Text(
                                          style: TextStyle(
                                              color: Color(
                                                  ColorConstants.brancoPadrao),
                                              fontWeight: FontWeight.bold),
                                          "Reps"),
                                      Expanded(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: new Border.all(
                                              color: Color(
                                                  ColorConstants.brancoPadrao),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value){
                                              if (value!.isEmpty) {
                                                return 'Informe';
                                              }
                                            },
                                            onChanged: (value) => {
                                              exerciciosRequest[index]
                                                  .series[indexSerie]
                                                  .repeticoes = int.parse(value)
                                            },
                                            controller: exerciciosRequest[index]
                                                .series[indexSerie]
                                                .controllerReps,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(ColorConstants
                                                    .brancoPadrao),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Carga",
                                        style: TextStyle(
                                            color: Color(
                                                ColorConstants.brancoPadrao),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: new Border.all(
                                              color: Color(
                                                  ColorConstants.brancoPadrao),
                                              width: 1.0,
                                            ),
                                          ),
                                          child: TextFormField(
                                            validator: (value){
                                              if (value!.isEmpty) {
                                                return 'Informe';
                                              }
                                            },
                                            onChanged: (value) => {
                                              exerciciosRequest[index]
                                                  .series[indexSerie]
                                                  .carga = double.parse(value)
                                            },
                                            controller: exerciciosRequest[index]
                                                .series[indexSerie]
                                                .controllerCarga,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(ColorConstants
                                                    .brancoPadrao),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                          ButtonDefault(
                            funcao: () {
                              _adicionarSerie(index);
                            },
                            label: "Adicionar série",
                            cor: Color(ColorConstants.azulEscuroPadrao),
                          )
                        ]),
                      ),
                      onTap: () {
                        Navigator.pop(context, exercicio);
                      },
                    );
                  }),
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
            carregando
                ? CircularProgressIndicator()
                : ButtonDefault(
                    funcao: () async{
                      await _salvarTreino();
                    },
                    label: "Salvar treino",
                    cor: Color(ColorConstants.verdeEscuroPadrao),
                  ),
          ]),
        ),
      ]),
    );
  }
}
