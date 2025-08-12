import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gym_squad_front_end/business/treinos_inidividuais_business.dart';
import 'package:gym_squad_front_end/components/commum/alert_dialog_default.dart';
import 'package:gym_squad_front_end/components/commum/background_completo_default.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/store/store.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late TreinosInidividuaisBusiness treinosInidividuaisBusiness;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstants.fundoApp),
      body: Center(
        child: Image.asset(
          width: 200,
          'assets/images/logo.png',
          fit: BoxFit.contain, // Ajusta a imagem para cobrir toda a tela
        ).animate(
          onPlay: (controller) => controller.repeat(reverse: true), // loop
        )
        .scale(
          duration: 800.ms,
          curve: Curves.easeInOut,
          begin: const Offset(1.0, 1.0), // tamanho normal
          end: const Offset(1.2, 1.2), // aumenta 10%
        ),
      ),
    );
  }

  @override
  void initState() {
    
    treinosInidividuaisBusiness = TreinosInidividuaisBusiness();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      
      try{
        var credenciais = await _retornarCredenciais();

        if(credenciais != null){
          await treinosInidividuaisBusiness.sincronizarTreinosFinalizados();
          Navigator.pushReplacementNamed(context,
                                       '/home');
        }
        else{
          Navigator.pushReplacementNamed(context,
                                       '/login');
        }

        

      }
      catch (e){
        
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

  Future<LoginResponse?> _retornarCredenciais() async{
    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    if(credenciais != null){
      return LoginResponse.fromJson(credenciais!);
    }
    return null;
  }
}