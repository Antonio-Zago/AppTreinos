import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/store/store.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class DrawerDefault extends StatefulWidget {
  const DrawerDefault({super.key});

  @override
  State<DrawerDefault> createState() => _DrawerDefaultState();
}

class _DrawerDefaultState extends State<DrawerDefault> {

  LoginResponse? credenciais;
  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
 
    return Drawer(
      backgroundColor: Color(ColorConstants.fundoApp),
      child: ListView(
        children: [
           UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(ColorConstants.douradoPadrao)
            ),
              accountName: credenciais == null ? CircularProgressIndicatorDefault(): Text(
                credenciais!.usuario,
              ),
              accountEmail: credenciais == null ? CircularProgressIndicatorDefault(): Text(credenciais!.email),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: bytes != null ? MemoryImage(bytes!) : null,
                backgroundColor: Color(ColorConstants.brancoPadrao),
              ),
            ),
          ListTile(
            title: Text(
              "Grupos",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.group_outlined,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: (){
              Navigator.pushNamed(
                                      context,
                                      '/home',
                                    );
             },
          ),
          ListTile(
            title: Text(
              "Treinos",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.fitness_center,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: (){
               Navigator.pushNamed(
                                      context,
                                      '/treinos-individuais',
                                    );
             },
          ),

          ListTile(
            title: Text(
              "Histórico",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.calendar_month,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: (){
               Navigator.pushNamed(
                                      context,
                                      '/calendario-treinos',
                                    );
             },
          ),

          ListTile(
            title: Text(
              "Configurações",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.settings,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: () async{


             },
          ),

          ListTile(
            title: Text(
              "Sair",
              style: TextStyle(
                color: Color(ColorConstants.brancoPadrao),
                fontSize: 20
              ),
            ),
            leading: Icon(
              Icons.output,
              color: Color(ColorConstants.brancoPadrao),
            ),
             trailing: Icon(Icons.arrow_forward),
             onTap: () async{

              await _resetarCredenciais();

               Navigator.pushNamed(
                                      context,
                                      '/login',
                                    );
             },
          ),
          
        ],
      )
    );
  }

  @override
  void initState() {
    
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try{
        var credenciaisResponse = await _retornarCredenciais();
        setState(() {
          credenciais = credenciaisResponse;
          if(credenciais != null){
            if(credenciais!.foto != null){
              bytes = base64Decode(credenciais!.foto!);
            }      
          }
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
      
    });
  }

  Future<LoginResponse>  _retornarCredenciais() async{
    var credenciaisJson = await Store.retornarValor("Credenciais");

    return LoginResponse.fromJson(credenciaisJson!);
  }

  _resetarCredenciais() async{
    await Store.resetarValor("Credenciais");
  }

  
}