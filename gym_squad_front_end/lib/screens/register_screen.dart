import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/login_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController senhaRepitController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  
  LoginBusiness loginBusiness = LoginBusiness();
  final _formKey = GlobalKey<FormState>();
  bool fazendoCadastro = false;

  Future<void> _cadastrar() async{
    setState(() {
      fazendoCadastro = true;
    });

     if (!_formKey.currentState!.validate()){
      setState(() {
        fazendoCadastro = false;
      });
      return;
     }

    try{
      await loginBusiness.cadastrar(emailController.text, senhaController.text, nomeController.text);

      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialogDefault(
            message: "Usuário cadastrado com sucesso!",
            caminhoImagem: "assets/images/icones/ok.png",
          );
        }
      ).then((value) {
          Navigator.pushReplacementNamed(context, '/');
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
      fazendoCadastro = false;
    });

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
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 150, 30, 30),
              child: Column(
                children: [
                  
                  TextFieldDefault(
                    titulo: "Nome de usuário",
                    controller: nomeController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe o nome de usuário';
                      }
                    },
                  ),
            
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
            
                  TextFieldDefault(
                    titulo: "Repita a senha",
                    controller: senhaRepitController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe a senha';
                      }
                      else if(value != senhaController.text){
                        return 'Senhas não coincidem';
                      }
                    },
                    //Falta o botão icone para 
                    campoSenha: true,
                  ),
                  fazendoCadastro ?
                  CircularProgressIndicatorDefault(
                        
                  ) :
                  ButtonDefault(
                    funcao: () async {
                     await _cadastrar();
                    }, 
                    label: "Cadastrar"
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}