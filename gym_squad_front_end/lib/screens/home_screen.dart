import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/drawer_default.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  GrupoBusiness grupoBusiness = GrupoBusiness();
  List<UsuarioGrupoResponse> grupos = [];
  bool carregouGrupos = true;

  Future<List<UsuarioGrupoResponse>> _retornarGruposDoUsuario() async{

    return await grupoBusiness.getGruposByUserId();

  }

  @override
  void initState() {
    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        carregouGrupos = false;
      });
      var response = await _retornarGruposDoUsuario();
      setState(() {
        carregouGrupos = true;
        grupos = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarDefault(
        title: "Grupos atuais",
      ),
      drawer: DrawerDefault(),
      body: BackgroundCompletoDefault(
        children: [
          !carregouGrupos ?
          CircularProgressIndicatorDefault() :

          grupos.isEmpty ?
             Image.asset(
                "assets/images/squad-home.png",
              )
          :
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: grupos.length,
            itemBuilder: (context,index){
              return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(ColorConstants.linhasGrids),
                      child: ListTile(
                        title: Text(
                          grupos[index].nome,
                          style: TextStyle(
                            color: Color(ColorConstants.brancoPadrao),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        ),
                        onTap: (){
                          Navigator.pushNamed(
                                        context,
                                        '/grupo',
                                        arguments: <String, dynamic>{
                                          'grupo': grupos[index]
                                        },
                                      );
                        },
                      ),
                    );
            }
          ),
          Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.only(right: 15),
                        child: CircleAvatar(
                          backgroundColor:Color(ColorConstants.douradoPadrao),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/grupo-busca');
                            },
                            icon: Icon(Icons.search_outlined),
                            color:Color(ColorConstants.linhasGrids)
                          ),
                          radius: 25,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor:Color(ColorConstants.douradoPadrao),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/grupo-novo');
                          },
                          icon: Icon(Icons.add_outlined),
                          color:Color(ColorConstants.linhasGrids)
                        ),
                        radius: 25,
                      )
                    ]
                  ),
                ),
                
          
          
        ]
      ),
    );
  }
}