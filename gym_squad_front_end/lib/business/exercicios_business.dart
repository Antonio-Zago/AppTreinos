import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/memoria/exercicios.dart';
import 'package:gym_squad_front_end/store/store.dart';

class ExerciciosBusiness {

  ApiClient apiClient = ApiClient();

  Future<Exercicios?> getAllExercicios() async{

    var credenciais = await _retornarCredenciais();

    Exercicios? exercicios; 

    var exerciciosDispositivoJson = await _retornarExerciciosDoDispositivo(credenciais.id);

    if(exerciciosDispositivoJson != null){
      exercicios = Exercicios.fromJson(exerciciosDispositivoJson);
    }

    final temInternet = await Connectivity().checkConnectivity(); 

    if(temInternet[0] != ConnectivityResult.none){
      var exerciciosResponse = await apiClient.getAllExercicios(credenciais.token);   

      exercicios = Exercicios(exerciciosResponse);
    }

    //Aqui eu estou gravando os exercicios que vem da API no dispositivo
    //no momento da busca, mas o certo é colocar esse método no momento 
    //da tela de splash do dispositivo por exemplo
    //await _gravarExerciciosNoDispositivo(exercicios,credenciais.id);

    return exercicios;

  }

  Future<LoginResponse> _retornarCredenciais() async{
    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    return LoginResponse.fromJson(credenciais!);
  }

  Future<void> _gravarExerciciosNoDispositivo (Exercicios exercicios, int idUsuario) async{
    Store.salvarValor("exercicios#$idUsuario", exercicios.toJson());
  }


  Future<Map<String,dynamic>?> _retornarExerciciosDoDispositivo (int idUsuario) async{
    return Store.retornarValor("exercicios#$idUsuario");
  }

}