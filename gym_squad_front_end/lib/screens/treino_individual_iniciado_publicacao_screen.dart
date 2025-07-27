import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class TreinoIndividualIniciadoPublicacaoScreen extends StatefulWidget {
  const TreinoIndividualIniciadoPublicacaoScreen({super.key});

  @override
  State<TreinoIndividualIniciadoPublicacaoScreen> createState() => _TreinoIndividualIniciadoPublicacaoScreenState();
}

class _TreinoIndividualIniciadoPublicacaoScreenState extends State<TreinoIndividualIniciadoPublicacaoScreen> {

  bool carregouGrupos = false;
  GrupoBusiness grupoBusiness = GrupoBusiness();
  List<UsuarioGrupoResponse> grupos = [];
  TextEditingController tituloController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  Map<String, bool> listGrupoSelecionadosController = {};

  Future<bool> _mostrarDialogoConfirmacao(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente sair da tela? Não será publicado o treino em nenhum grupo'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Sair'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final confirmarSaida = await _mostrarDialogoConfirmacao(context);
        if (confirmarSaida && context.mounted) {
          Navigator.of(context).pop(result); // passa o valor original
        }
      },
      child: Scaffold(
        appBar: AppBarDefault(
          title: "Nova publicação",
        ),
        body:BackgroundCompletoDefault(
          children: [
            !carregouGrupos ?
            CircularProgressIndicatorDefault() :
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldDefault(
                    controller: tituloController,
                    titulo: "TITULO",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe o titulo da publicação';
                      }
                    },
                  ),
                  Text(
                    "Selecione os grupos",
                    style: TextStyle(
                                          color: Color(ColorConstants.brancoPadrao),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                  ),
      
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: grupos.length,
                    itemBuilder: (context, index) {
      
                      var codigoGrupo = grupos[index].codigo; 
      
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        color: Color(ColorConstants.linhasGrids),
                        child: CheckboxListTile(
                            side: BorderSide(
                              color: Color(ColorConstants.brancoPadrao)
                            ),
                            activeColor: Colors.green,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  grupos[index].nome,
                                  style: TextStyle(
                                          color: Color(ColorConstants.brancoPadrao),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                ),
                               
                              ]
                            ), 
                            value: listGrupoSelecionadosController["$codigoGrupo"], 
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (bool? value) { 
                              setState(() {
                                     listGrupoSelecionadosController["$codigoGrupo"] = ! listGrupoSelecionadosController["$codigoGrupo"]!;
                                  });
                            },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 20),
                    child: TextFieldDefault(
                      campoDescricao: true,
                      controller: descricaoController,
                      titulo: "DESCRIÇÃO",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Informe o titulo da publicação';
                        }
                      },
                    ),
                  ), 
                  ButtonDefault(funcao: () async{
                     
                    await _gravarPublicacoes();
                  
                  }, 
                  label: "Postar publicações")              
                ]
              ),
            ),
          ]
        )
      ),
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
        var response = await _retornarGrupos();

        for(var grupo in response){

          var codigoGrupo = grupo.codigo;  

          listGrupoSelecionadosController["$codigoGrupo"] = false;
        }

        setState(() {
          carregouGrupos = true;
          grupos = response;
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

  Future<List<UsuarioGrupoResponse>> _retornarGrupos() async{

    return await grupoBusiness.getGruposByUserId();

  }

  Future<void> _gravarPublicacoes() async{
    
    setState(() {
      carregouGrupos = false;
    });

    List<int> listaCodigosGrupos = [];

    for(var grupo in grupos){

      var codigoGrupo = grupo.codigo;

      if(listGrupoSelecionadosController["$codigoGrupo"]!){
        listaCodigosGrupos.add(codigoGrupo);
      }
    }
    
    try{
      await grupoBusiness.postarPublicacoes(tituloController.text, descricaoController.text, listaCodigosGrupos);

      setState(() {
        carregouGrupos = true;
      });
      Navigator.pushReplacementNamed(
                                          context,
                                          '/treinos-individuais'
                                        );
    }catch (e){
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

  }
}