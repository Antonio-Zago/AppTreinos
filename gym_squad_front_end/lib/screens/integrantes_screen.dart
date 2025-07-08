import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class IntegrantesScreen extends StatefulWidget {
  const IntegrantesScreen({super.key});

  @override
  State<IntegrantesScreen> createState() => _IntegrantesScreenState();
}

class _IntegrantesScreenState extends State<IntegrantesScreen> {

  GrupoBusiness grupoBusiness = GrupoBusiness();
  bool carregouGrupos = true;
  List<UsuarioGrupoResponse> usuarios = [];
  int? grupoId;
  bool? ehAdmin;
  int? usuarioId;

  Future<List<UsuarioGrupoResponse>> _retornarIntegrantesGrupo() async{

    return await grupoBusiness.getUsersByGrupoId(grupoId!);

  }

  Future<void> _excluirIntegrantesGrupo(int userId) async{
    try{
      await grupoBusiness.deleteByGrupoIdAndUserId(grupoId!,userId);
      setState(() {
        usuarios.removeWhere((a) => a.usuarioId == userId);
      });
    }catch (e){
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

  Future _mostrarDialogoDeletarUsuarioGrupo(BuildContext context, int usuarioId) async {

    return showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
          title: Text('Deseja excluir o usuário do grupo?'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: Text('Não')
            ),
            TextButton(
              onPressed: () async{
                await _excluirIntegrantesGrupo(usuarioId);

                Navigator.of(context).pop();
              }, 
              child: Text('Sim')
            )
          ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    grupoId = args["grupoId"];
    ehAdmin = args["ehAdmin"];

    return Scaffold(
      appBar: AppBarDefault(
        title: "Integrantes",
      ),
      body:BackgroundCompletoDefault(
        children: [
          !carregouGrupos ?
          CircularProgressIndicatorDefault() :
           ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: usuarios.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(ColorConstants.linhasGrids),
                      child: ListTile(
                        title: Text(
                          '${usuarios[index].nomeUsuario}',
                          style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      trailing: ehAdmin! ? CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color(ColorConstants.douradoPadrao),
                                child: IconButton(
                                    onPressed: () {
                                      _mostrarDialogoDeletarUsuarioGrupo(context, usuarios[index].usuarioId);
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Color(ColorConstants.linhasGrids)),
                              ) : null,
                      
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
        var response = await _retornarIntegrantesGrupo();

        setState(() {
          carregouGrupos = true;
          usuarios = response;
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