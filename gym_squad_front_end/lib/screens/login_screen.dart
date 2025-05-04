import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/login_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/exceptions/unauthorized_exception.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  bool fazendoLogin = false;
  LoginBusiness loginBusiness = LoginBusiness();
  final _formKey = GlobalKey<FormState>();

  Future<void> login() async{
    setState(() {
      fazendoLogin = true;
    });

     if (!_formKey.currentState!.validate()){
      setState(() {
        fazendoLogin = false;
      });
      return;
     }

    try{
      await loginBusiness.login(emailController.text, senhaController.text);


    }on UnauthorizedException catch(e){
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialogDefault(
            message: e.message,
            caminhoImagem: "assets/images/icones/erro.png",
          );
        });
    }on Exception catch(e){
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
      fazendoLogin = false;
    });

    Navigator.pushReplacementNamed(context, '/treinos-individuais');
  
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(ColorConstants.fundoApp),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 200,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(150)),
                    color: Color(ColorConstants.brancoPadrao),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 150, 30, 30),
                    child: Column(
                      children: [
                    
                        TextFieldDefault(
                          titulo: "Email",
                          controller: emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe o email';
                            }
                          },
                        ),
                        
                        TextFieldDefault(
                          titulo: "Senha",
                          controller: senhaController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Informe a senha';
                            }
                          },
                        ),
                        fazendoLogin ?
                        CircularProgressIndicatorDefault(
            
                        ) :
                        ButtonDefault(
                          funcao: () async {
                            await login();
                          }, 
                          label: "Entrar"
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
