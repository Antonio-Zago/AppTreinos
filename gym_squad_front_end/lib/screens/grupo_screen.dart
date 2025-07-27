import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/banner_nome_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/components/grupos/button_group.dart';
import 'package:gym_squad_front_end/models/api/grupos/publicacao_paginacao_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/publicacao_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/solicitacoes_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class GrupoScreen extends StatefulWidget {
  const GrupoScreen({super.key});

  @override
  State<GrupoScreen> createState() => _GrupoScreenState();
}

class _GrupoScreenState extends State<GrupoScreen> {

  UsuarioGrupoResponse? grupoSelecionado;
  bool carregouPublicacoes = false;
  late PublicacaoPaginacaoResponse publicacoes;
  late final GrupoBusiness grupoBusiness; 
  late final ScrollController _scrollController;
  late int _paginaAtual;
  bool carregouNovasPublicacoes = true;

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    grupoSelecionado = args["grupo"];

    return Scaffold(
      appBar: AppBarDefault(
        title: "Grupo: ${grupoSelecionado!.nome}",
      ),
      body:BackgroundCompletoDefault(
        scrollController: _scrollController,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(left: 10,right: 10, top: 20),
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonGroup(
                  funcao: (){
                    Navigator.pushNamed(
                                        context,
                                        '/grupo-integrantes',
                                        arguments: <String, dynamic>{
                                          'codigo': grupoSelecionado!.codigo,
                                          'grupoId': grupoSelecionado!.grupoId,
                                          'ehAdmin' : grupoSelecionado!.ehAdmin
                                        },
                                      );
                  }, 
                  label: "Integrantes"
                ),
                grupoSelecionado!.ehAdmin ?
                ButtonGroup(
                  funcao: (){
                    Navigator.pushNamed(
                                        context,
                                        '/grupo-solicitacoes',
                                        arguments: <String, dynamic>{
                                          'codigo': grupoSelecionado!.codigo,
                                          'grupoId': grupoSelecionado!.grupoId,
                                        },
                                      );
                  }, 
                  label: "Solicitações"
                ) :
                Container()
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 10,right: 10, top: 20),
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ButtonGroup(
                  funcao: (){
                    Navigator.pushNamed(
                                        context,
                                        '/grupo-ranking',
                                        arguments: <String, dynamic>{
                                          'codigo': grupoSelecionado!.codigo,
                                          'grupoId': grupoSelecionado!.grupoId,
                                        },
                                      );
                  }, 
                  label: "Ranking"
                ),
              ]
            )
          ),
          !carregouPublicacoes ?
          CircularProgressIndicatorDefault() :

          Padding(
            padding: EdgeInsetsGeometry.only(top: 15),
            child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: publicacoes.dados.length ,
                    itemBuilder: (context, index) {
                      
                      String dataFormatada = DateFormat("dd/MM/yyyy hh:mm").format(publicacoes.dados[index].dataHora);

                      Uint8List? bytes;
                      if(publicacoes.dados[index].foto != null && publicacoes.dados[index].foto != ""){
                        bytes = base64Decode(publicacoes.dados[index].foto!);
                      }

                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        color: Color(ColorConstants.linhasGrids),
                        child: ListTile(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    publicacoes.dados[index].nomeUsuario,
                                    style: TextStyle(
                                        color: Color(ColorConstants.douradoPadrao),
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    dataFormatada,
                                    style: TextStyle(
                                        color: Color(ColorConstants.douradoPadrao),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${publicacoes.dados[index].titulo}',
                                  style: TextStyle(
                                      color: Color(ColorConstants.brancoPadrao),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '${publicacoes.dados[index].descricao}',
                                  style: TextStyle(
                                      color: Color(ColorConstants.brancoPadrao),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              bytes != null ?
                              Image.memory(
                                bytes,
                                width: 200,
                                height: 200,
                              ):
                              Container()
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          carregouNovasPublicacoes ?
          Container() :
          CircularProgressIndicatorDefault()
        ]
      )
    );
  }

  Future<PublicacaoPaginacaoResponse> _retornarPublicacoesGrupo(int page) async{

    return await grupoBusiness.getPublicacoesByGrupoId(grupoSelecionado!.codigo, page);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _scrollController.dispose();
  }

  infiniteScrolling() async{
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && carregouPublicacoes){

       if(publicacoes.totalPaginas >= _paginaAtual){
        setState(() {
          carregouNovasPublicacoes = false;
        });
        _paginaAtual = _paginaAtual + 1;
        var response = await _retornarPublicacoesGrupo(_paginaAtual);
        setState(() {
          publicacoes.dados.addAll(response.dados);
          carregouNovasPublicacoes = true;
        });
       }
    }
  }


  @override
  void initState() {
    
     
    grupoBusiness = GrupoBusiness();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        carregouPublicacoes = false;
      });
      try{
        _paginaAtual = 1;
        var response = await _retornarPublicacoesGrupo(_paginaAtual);

        setState(() {
          carregouPublicacoes = true;
          publicacoes = response;
        });
      }
      catch (e){
        setState(() {
          carregouPublicacoes = true;
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

    super.initState();
  }
}