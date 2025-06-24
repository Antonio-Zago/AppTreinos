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

      setState(() {
        fazendoLogin = false;
      });

      Navigator.pushReplacementNamed(context, '/home');

    }on Exception catch(e){
      setState(() {
        fazendoLogin = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo-login.png'),
            fit: BoxFit.cover, // cobre toda a tela
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
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
                        //Falta o botão icone para 
                        campoSenha: true,
                      ),
                      fazendoLogin ?
                      CircularProgressIndicatorDefault(
                            
                      ) :
                      ButtonDefault(
                        funcao: () async {
                          await login();
                        }, 
                        label: "Entrar"
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: TextButton(
                          child: Text(
                            'CADASTRE-SE',
                            style: TextStyle(
                              color: Color(ColorConstants.brancoPadrao),
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                              context,
                                                      '/registro-usuario',
                                                    );
                          },
                        ),
                      )
                    ],
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
