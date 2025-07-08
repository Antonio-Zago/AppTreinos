import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/grupo_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/app_bar_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/components/commum/button_default.dart';
import 'package:gym_squad_front_end/components/commum/text_field_default.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class GrupoNovoScreen extends StatefulWidget {
  const GrupoNovoScreen({super.key});

  @override
  State<GrupoNovoScreen> createState() => _GrupoNovoScreenState();
}

class _GrupoNovoScreenState extends State<GrupoNovoScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  GrupoBusiness grupoBusiness = GrupoBusiness();
  bool carregando = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: "NOVO GRUPO",
      ),
      body: BackgroundCompletoDefault(children: [
        Form(
          key: _formKey,
          child: Column(children: [
            TextFieldDefault(
              controller: nomeController,
              titulo: "NOME",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o nome do grupo';
                }
              },
            ),
            carregando ?
            CircularProgressIndicator() :
            ButtonDefault(
                    funcao: () async{
                      await _salvarGrupo();
                    },
                    label: "Salvar grupo",
                    cor: Color(ColorConstants.verdeEscuroPadrao),
                  ),
          ]),
        ),
      ]),
    );
  }

  Future _salvarGrupo() async {
    setState(() {
      carregando = true;
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        carregando = false;
      });
      return;
    } 
    
    await grupoBusiness.postGrupo(nomeController.text);

    setState(() {
      carregando = false;
    });

    await _mostrarDialogo();

    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  Future _mostrarDialogoErro(String mensagem) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialogDefault(
              message: mensagem,
              caminhoImagem: "assets/images/icones/erro.png",
            ));
  }

   Future _mostrarDialogo() async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialogDefault(
              message: "Grupo cadastrado com sucesso!",
              caminhoImagem: "assets/images/icones/ok.png",
            ));
  }
}