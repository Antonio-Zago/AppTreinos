import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class GrupoBuscaScreen extends StatefulWidget {
  const GrupoBuscaScreen({super.key});

  @override
  State<GrupoBuscaScreen> createState() => _GrupoBuscaScreenState();
}

class _GrupoBuscaScreenState extends State<GrupoBuscaScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController codigoController = TextEditingController();
  GrupoBusiness grupoBusiness = GrupoBusiness();
  bool carregando = false;
  GrupoResponse? grupoResponse;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "BUSCAR GRUPO",
      ),
      body: BackgroundCompletoDefault(children: [
        Form(
          key: _formKey,
          child: Column(children: [
            TextFieldDefault(
              campoNumerico: true,
              controller: codigoController,
              titulo: "CÓDIGO",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o código do grupo';
                }
              },
            ),
            grupoResponse == null?
            Text("") :
            Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(ColorConstants.linhasGrids),
                      child: ListTile(
                        title: Text(
                          '${grupoResponse!.nome}',
                          style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: 
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color(ColorConstants.douradoPadrao),
                                child: IconButton(
                                    onPressed: () async{
                                      await _enviarSolicitacaoGrupo();
                                    },
                                    icon: Icon(Icons.input_outlined),
                                    color: Color(ColorConstants.linhasGrids)),
                              ),
                          ),
                      ),
            carregando ?
            CircularProgressIndicator() :
            ButtonDefault(
                    funcao: () async{
                      await _buscarGrupo();
                    },
                    label: "Buscar grupo",
                    cor: Color(ColorConstants.douradoPadrao),
                  ),
          ]),
        ),
      ]),
    );
  }

  Future _buscarGrupo() async {
    setState(() {
      carregando = true;
      grupoResponse = null;
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        carregando = false;
      });
      return;
    } 
    
    try{
        grupoResponse = await grupoBusiness.getGrupoByCodigo(int.parse(codigoController.text));
      }
      on Exception catch (e){
        showDialog(
          context: context, 
          builder: (BuildContext context){
            return AlertDialogDefault(
              message: e.toString(),
              caminhoImagem: "assets/images/icones/erro.png",
            );
          });
      }
  
    setState(() {
      carregando = false;
    });

  }

  Future _enviarSolicitacaoGrupo() async {
    setState(() {
      carregando = true;
    });
    
    await grupoBusiness.enviarSolicitacao(int.parse(codigoController.text));

    setState(() {
      carregando = false;
    });

    await _mostrarDialogo();

    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  Future _mostrarDialogo() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialogDefault(
              message: "Solicitação enviada com sucesso!",
              caminhoImagem: "assets/images/icones/ok.png",
            ));
  }
}