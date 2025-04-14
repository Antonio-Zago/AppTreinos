import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/login_request.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos.dart';
import 'package:gym_squad_front_end/store/store.dart';

class TreinosInidividuaisBusiness {

  ApiClient apiClient = ApiClient();

  Future<UsuarioTreinos> getTreinosByUserId() async{

    UsuarioTreinos usuarioTreinos;

    var credenciais = await _retornarCredenciais();

    var treinosIndividuaisNoDispositivoJson = await _retornarTreinosDoDispositivo(credenciais.id);

    if(treinosIndividuaisNoDispositivoJson != null){
      usuarioTreinos = UsuarioTreinos.fromJson(treinosIndividuaisNoDispositivoJson);
    }
      
    List<UsuarioTreinosResponse> usuarioTreinosResponse = await apiClient.getTreinosByUserId(credenciais.token,credenciais.id);      
    
    usuarioTreinos = UsuarioTreinos(usuarioTreinosResponse);

    _gravarTreinosNoDispositivo(usuarioTreinos, credenciais.id);

    return usuarioTreinos;

  }

  Future<void> postTreinoFinalizado(List<ExercicioIniciadoRequest> exercicios, int treinoId) async{

    var credenciais = await _retornarCredenciais();
      
    TreinoIniciadoRequest request = TreinoIniciadoRequest(credenciais.id,treinoId, exercicios);

     await apiClient.postTreinoFinalizado(request, credenciais.token);      

  }

  Future<LoginResponse> _retornarCredenciais() async{
    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    return LoginResponse.fromJson(credenciais!);
  }

  Future<void> _gravarTreinosNoDispositivo (UsuarioTreinos usuarioTreinos, int idUsuario) async{
    Store.salvarValor("treinosIndividuais#$idUsuario", usuarioTreinos.toJson());
  }

  Future<Map<String,dynamic>?> _retornarTreinosDoDispositivo (int idUsuario) async{
    return Store.retornarValor("treinosIndividuais#$idUsuario");
  }

  

  

}