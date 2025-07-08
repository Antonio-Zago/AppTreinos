import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/banner_nome_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/components/grupos/button_group.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class GrupoScreen extends StatefulWidget {
  const GrupoScreen({super.key});

  @override
  State<GrupoScreen> createState() => _GrupoScreenState();
}

class _GrupoScreenState extends State<GrupoScreen> {

  UsuarioGrupoResponse? grupoSelecionado;

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    grupoSelecionado = args["grupo"];

    return Scaffold(
      appBar: AppBarDefault(
        title: "Grupo: ${grupoSelecionado!.nome}",
      ),
      body:BackgroundCompletoDefault(
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
                  funcao: (){}, 
                  label: "Ranking"
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}