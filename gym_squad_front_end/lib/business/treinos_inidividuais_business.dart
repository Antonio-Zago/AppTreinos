import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/login_request.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos.dart';
import 'package:gym_squad_front_end/store/store.dart';

class TreinosInidividuaisBusiness {

  ApiClient apiClient = ApiClient();

  Future<UsuarioTreinos?> getTreinosByUserId() async{

    UsuarioTreinos? usuarioTreinos;

    var credenciais = await _retornarCredenciais();

    var treinosIndividuaisNoDispositivoJson = await _retornarTreinosDoDispositivo(credenciais.id);

    if(treinosIndividuaisNoDispositivoJson != null){
      usuarioTreinos = UsuarioTreinos.fromJson(treinosIndividuaisNoDispositivoJson);
    }
      
    //Aqui é necessário para ver se tem diferença entre o gravado no celular
    // e no banco de dados

    final temInternet = await Connectivity().checkConnectivity(); 

    if(temInternet[0] != ConnectivityResult.none){
      List<UsuarioTreinosResponse> usuarioTreinosResponse = await apiClient.getTreinosByUserId(credenciais.token,credenciais.id);      
    
      usuarioTreinos = UsuarioTreinos(usuarioTreinosResponse);
    }

    return usuarioTreinos;

  }

  Future<void> postTreinoFinalizado(List<ExercicioIniciadoRequest> exercicios, int treinoId) async{

    var credenciais = await _retornarCredenciais();
      
    TreinoIniciadoRequest request = TreinoIniciadoRequest(credenciais.id,treinoId, exercicios);

    await apiClient.postTreinoFinalizado(request, credenciais.token);   

    //TODO
    //Tenho que salvar as alterações desse treino finalizado no dispositivo

  }

  Future<void> postTreinoNovo(List<TreinoExerciciosRequest> exercicios, String nomeTreino) async{

    var credenciais = await _retornarCredenciais();
    
    UsuarioTreinosRequest request = UsuarioTreinosRequest(credenciais.id,nomeTreino, exercicios, null);

    UsuarioTreinos usuarioTreinos;

    var treinosDispositivo = await _retornarTreinosDoDispositivo(credenciais.id);

    final temInternet = await Connectivity().checkConnectivity(); 

    if(temInternet[0] != ConnectivityResult.none){ //Salva no banco e depois salva no dispositivo
      var novoTreinoResponse = await apiClient.postTreinoNovo(request, credenciais.token);  

      List<TreinoExerciciosResponse> exerciciosNovo = [];
    
      for(var exercicio in novoTreinoResponse.exercicios){

        List<SerieResponse> seriesNovas = [];

        for(var serie in exercicio.series){
          SerieResponse serieNova = SerieResponse(serie.repeticoes, serie.carga);
          seriesNovas.add(serieNova);
        }

        TreinoExerciciosResponse exercicioNovo = TreinoExerciciosResponse(exercicio.id, exercicio.foto,exercicio.nome,seriesNovas);
        exerciciosNovo.add(exercicioNovo);
      }

      //Tipo dos treinos salvos no dispositivo
      UsuarioTreinosResponse novoTreino = UsuarioTreinosResponse(credenciais.id,novoTreinoResponse.treinoId,nomeTreino,exerciciosNovo);

       if(treinosDispositivo != null){
        usuarioTreinos = UsuarioTreinos.fromJson(treinosDispositivo);

        usuarioTreinos.treinos.add(novoTreino);
      }
      else{
        List<UsuarioTreinosResponse> novoListaTreinos = [];
        novoListaTreinos.add(novoTreino);
        usuarioTreinos = UsuarioTreinos(novoListaTreinos);
      }

    }
    else{ //Só salva no dispositivo sem o id do treino
      List<TreinoExerciciosResponse> exerciciosNovo = [];
    
      for(var exercicio in request.exercicios){

        List<SerieResponse> seriesNovas = [];

        for(var serie in exercicio.series){
          SerieResponse serieNova = SerieResponse(serie.repeticoes, serie.carga);
          seriesNovas.add(serieNova);
        }

        TreinoExerciciosResponse exercicioNovo = TreinoExerciciosResponse(null, exercicio.foto,exercicio.nome,seriesNovas);
        exerciciosNovo.add(exercicioNovo);
      }

      //Tipo dos treinos salvos no dispositivo
      UsuarioTreinosResponse novoTreino = UsuarioTreinosResponse(credenciais.id,null,nomeTreino,exerciciosNovo);

       if(treinosDispositivo != null){
        usuarioTreinos = UsuarioTreinos.fromJson(treinosDispositivo);

        usuarioTreinos.treinos.add(novoTreino);
      }
      else{
        List<UsuarioTreinosResponse> novoListaTreinos = [];
        novoListaTreinos.add(novoTreino);
        usuarioTreinos = UsuarioTreinos(novoListaTreinos);
      }
    }

    _gravarTreinosNoDispositivo(usuarioTreinos, credenciais.id);

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