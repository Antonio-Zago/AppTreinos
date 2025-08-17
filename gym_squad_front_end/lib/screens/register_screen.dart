import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/login_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/circular_progress_indicator_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker imagePicker = ImagePicker();
  File? imageFile;
  
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
      String base64String = "";

      if(imageFile != null){
        Uint8List bytes = await imageFile!.readAsBytes();
        base64String = base64.encode(bytes);
      }

      await loginBusiness.cadastrar(emailController.text, senhaController.text, nomeController.text, base64String);

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

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.photo_library,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  pick(ImageSource.camera);
                },
              ),
              
            ],
          ),
        );
      },
    );
  }

  pick(ImageSource source) async{
    var pickedFile = await imagePicker.pickImage(source: source);

    if(pickedFile != null){
      setState(() {
        imageFile = File(pickedFile.path);
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

                   Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 30),
                     child: Container(
                      alignment: Alignment.topLeft,
                      child: ElevatedButton.icon(
                        onPressed: (){
                          _showOpcoesBottomSheet();
                        }, 
                        icon: Icon(Icons.photo_library),
                        style: ElevatedButton.styleFrom(
                          iconColor: Color(ColorConstants.brancoPadrao),
                          backgroundColor: Color(ColorConstants.douradoPadrao),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        label: Text(
                          "Selecione uma imagem de perfil",
                          style: TextStyle(
                            color: Color(ColorConstants.brancoPadrao)
                          ),
                        ),
                      ),
                                       ),
                   ),
                  imageFile != null ?
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 30),
                    child: Image.file(imageFile!),
                  ) : 
                  Container(),

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