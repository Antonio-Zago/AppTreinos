import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/exercicio_finalizado.dart';
import 'package:gym_squad_front_end/models/memoria/serie_finalizado.dart';
import 'package:gym_squad_front_end/models/memoria/treino_finalizado.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos.dart';
import 'package:gym_squad_front_end/models/memoria/usuario_treinos_finalizados.dart';
import 'package:gym_squad_front_end/store/store.dart';

class TreinosInidividuaisBusiness {

  ApiClient apiClient = ApiClient();

  Future<UsuarioTreinos?> getAndUpdateTreinosByUserId() async{

    UsuarioTreinos? usuarioTreinos;

    var credenciais = await _retornarCredenciais();

    var treinosIndividuaisNoDispositivoJson = await _retornarTreinosDoDispositivo(credenciais.id);

    final temInternet = await Connectivity().checkConnectivity(); 

    if(treinosIndividuaisNoDispositivoJson != null){
      UsuarioTreinos? usuarioTreinosDispositivo = UsuarioTreinos.fromJson(treinosIndividuaisNoDispositivoJson);

      if(temInternet[0] != ConnectivityResult.none){

        List<UsuarioTreinosResponse> usuarioTreinosBanco = await apiClient.getTreinosByUserId(credenciais.token,credenciais.id);   

        for(var treinoDispositivo in usuarioTreinosDispositivo.treinos){

          //Aqui vou atualizar sempre os treinos no banco de dados
          //Caso alguma alteração tenha sido feita de forma offline
          List<TreinoExerciciosRequest> treinosRequest = [];

          for(var exercicio in treinoDispositivo.exercicios){
            List<SerieRequest> seriesRequest = [];
            for(var serie in exercicio.series){
              SerieRequest serieRequest = SerieRequest(serie.repeticoes,serie.carga);

              seriesRequest.add(serieRequest);
            }
            TreinoExerciciosRequest treinoExerciciosRequest = TreinoExerciciosRequest(exercicio.id!,seriesRequest,exercicio.foto,exercicio.nome);
            treinosRequest.add(treinoExerciciosRequest);
          }
          
          await postTreino(treinosRequest, treinoDispositivo.nomeTreino,treinoDispositivo.treinoId, false);
        }

        for(var usuarioTreinoBanco in usuarioTreinosBanco){
          var treinoBanco = usuarioTreinosDispositivo.treinos.firstWhereOrNull((a) => a.treinoId == usuarioTreinoBanco.treinoId);

          //Significa que foi apagado o registro do treino de forma offline
          //Necessário apagar do banco de dados agora
          if(treinoBanco == null){
            await deleteTreino(usuarioTreinoBanco.treinoId);
          }
        }
        var treinosIndividuaisNoDispositivoJson = await _retornarTreinosDoDispositivo(credenciais.id);
        usuarioTreinos = UsuarioTreinos.fromJson(treinosIndividuaisNoDispositivoJson!);
      }else{
        usuarioTreinos = usuarioTreinosDispositivo;
      }
    }
    else{
      if(temInternet[0] != ConnectivityResult.none){
        List<UsuarioTreinosResponse> usuarioTreinosResponse = await apiClient.getTreinosByUserId(credenciais.token,credenciais.id);      
        usuarioTreinos = UsuarioTreinos(usuarioTreinosResponse);

        await _gravarTreinosNoDispositivo(usuarioTreinos, credenciais.id);
      }else{
        return null;
      }
    }
      
    return usuarioTreinos;
  }

  Future<UsuarioTreinosResponse?> getTreinosByUserIdAndTreinoId(int treinoId) async{

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

    if(usuarioTreinos != null){
      return usuarioTreinos.treinos.firstWhere((treino) => treino.treinoId! == treinoId);
    }
    return null;

  }

   Future<void> deleteTreino(int? treinoId) async{
      
    UsuarioTreinos? usuarioTreinos;

    var credenciais = await _retornarCredenciais();

    final temInternet = await Connectivity().checkConnectivity(); 

    if(temInternet[0] != ConnectivityResult.none){
      await apiClient.deleteTreino(credenciais.token,treinoId!);      
    }

    //Apagar do dispositivo
    var treinosIndividuaisNoDispositivoJson = await _retornarTreinosDoDispositivo(credenciais.id);

    if(treinosIndividuaisNoDispositivoJson != null){
      usuarioTreinos = UsuarioTreinos.fromJson(treinosIndividuaisNoDispositivoJson);

      usuarioTreinos.treinos.removeWhere((u) => u.treinoId == treinoId);

      _gravarTreinosNoDispositivo(usuarioTreinos, credenciais.id);
    }
  }

  Future<UsuarioTreinosFinalizados?> retornarTreinosFinalizadoNoDispositivo() async{
    var credenciais = await _retornarCredenciais();

    var usuarioTreinosFinalizadosDispositivoJson = await _retornarTreinosFinalizadoNoDispositivo(credenciais.id);

    if(usuarioTreinosFinalizadosDispositivoJson != null){
      return UsuarioTreinosFinalizados.fromJson(usuarioTreinosFinalizadosDispositivoJson);
    }

    return null;
  }

  List<ExercicioFinalizado> _converterExerciciosResponseParaTreinoFinalizado(List<ExercicioIniciadoResponse> responseList){
    List<ExercicioFinalizado> exerciciosFinalizados = [];

    for(var response in responseList){
      ExercicioFinalizado exercicioFinalizado = ExercicioFinalizado();

      exercicioFinalizado.exercicioId = response.exercicioId;
      exercicioFinalizado.exercicioNome = response.exercicioNome;

      List<SerieFinalizado> seriesFinalizadas = [];

      for(var serie in response.dadosTreinoExercicioSeries){
        SerieFinalizado serieFinalizado = SerieFinalizado();
        serieFinalizado.carga = serie.carga;
        serieFinalizado.repeticoes = serie.repeticoes;
        seriesFinalizadas.add(serieFinalizado);
      }

      exercicioFinalizado.dadosTreinoExercicioSeries = seriesFinalizadas;

      exerciciosFinalizados.add(exercicioFinalizado);
    }

    return exerciciosFinalizados;
  }

  Future<void> sincronizarTreinosFinalizados() async{
    final temInternet = await Connectivity().checkConnectivity(); 

    if(temInternet[0] != ConnectivityResult.none){
      var credenciais = await _retornarCredenciais();

      var usuarioTreinosFinalizadosDispositivoJson = await _retornarTreinosFinalizadoNoDispositivo(credenciais.id);

      UsuarioTreinosFinalizados? usuarioTreinosFinalizadosDispositivo;

      if(usuarioTreinosFinalizadosDispositivoJson != null){
         usuarioTreinosFinalizadosDispositivo = UsuarioTreinosFinalizados.fromJson(usuarioTreinosFinalizadosDispositivoJson);
          for(var treino in usuarioTreinosFinalizadosDispositivo.treinos){
            if(!treino.sincronizado!){
              List<ExercicioIniciadoRequest> listaExerciciosRequest = [];

              for(var exercicio in treino.exercicios!){
                List<SerieIniciadoRequest> listaSeriesRequest = [];

                for(var serie in exercicio.dadosTreinoExercicioSeries!){
                  SerieIniciadoRequest serieIniciadaRequest = SerieIniciadoRequest(serie.repeticoes!,serie.carga!);
                  listaSeriesRequest.add(serieIniciadaRequest);
                }

                ExercicioIniciadoRequest exercicioIniciadoRequest = ExercicioIniciadoRequest(exercicio.exercicioId!,listaSeriesRequest, exercicio.exercicioNome!);
                listaExerciciosRequest.add(exercicioIniciadoRequest);
              }
              
              TreinoIniciadoRequest request = TreinoIniciadoRequest(credenciais.id,treino.treinoId!, listaExerciciosRequest);

              await apiClient.postTreinoFinalizado(request, credenciais.token);  

              treino.sincronizado = true;
            }
          }
          _gravarTreinosFinalizadoNoDispositivo(usuarioTreinosFinalizadosDispositivo, credenciais.id);
      }
    }
  }

  Future<TreinoFinalizado> postTreinoFinalizado(List<ExercicioIniciadoRequest> exercicios, int treinoId, String nomeTreino) async{

    var credenciais = await _retornarCredenciais();
      
    TreinoIniciadoRequest request = TreinoIniciadoRequest(credenciais.id,treinoId, exercicios);

    TreinoFinalizado treinoFinalizado = TreinoFinalizado();

    final temInternet = await Connectivity().checkConnectivity(); 

    var usuarioTreinosFinalizadosDispositivoJson = await _retornarTreinosFinalizadoNoDispositivo(credenciais.id);

    UsuarioTreinosFinalizados? usuarioTreinosFinalizadosDispositivo;

    if(temInternet[0] != ConnectivityResult.none){
      var treinoFinalizadoResponse = await apiClient.postTreinoFinalizado(request, credenciais.token);   

      treinoFinalizado.dataAtual = treinoFinalizadoResponse.dataAtual;
      treinoFinalizado.nomeTreino = nomeTreino;
      treinoFinalizado.treinoId = treinoFinalizadoResponse.treinoId;
      treinoFinalizado.exercicios = _converterExerciciosResponseParaTreinoFinalizado(treinoFinalizadoResponse.exercicios);
      treinoFinalizado.sincronizado = true;

      if(usuarioTreinosFinalizadosDispositivoJson == null){
        usuarioTreinosFinalizadosDispositivo = UsuarioTreinosFinalizados([], credenciais.id);
        usuarioTreinosFinalizadosDispositivo.treinos.add(treinoFinalizado);
      }
      else{
        usuarioTreinosFinalizadosDispositivo = UsuarioTreinosFinalizados.fromJson(usuarioTreinosFinalizadosDispositivoJson);
        usuarioTreinosFinalizadosDispositivo.treinos.add(treinoFinalizado);
      }
    }
    else{
      
      List<ExercicioIniciadoResponse> exerciciosIniciadoResponse = [];
      for(var exercicio in request.exercicios){
        
        List<SerieIniciadoResponse> seriesIniciadaResponse = [];
        for(var serie in exercicio.dadosTreinoExercicioSeries){
          var serieIniciadaResponse = SerieIniciadoResponse(serie.repeticoes, serie.carga, null);
          seriesIniciadaResponse.add(serieIniciadaResponse);
        }

        var exercicioIniciadoResponse = ExercicioIniciadoResponse(exercicio.exercicioId, seriesIniciadaResponse, exercicio.exercicioNome);

        exerciciosIniciadoResponse.add(exercicioIniciadoResponse);
      }

      treinoFinalizado = TreinoFinalizado();
      treinoFinalizado.dataAtual = DateTime.now();
      treinoFinalizado.exercicios = _converterExerciciosResponseParaTreinoFinalizado(exerciciosIniciadoResponse);
      treinoFinalizado.nomeTreino = nomeTreino;
      treinoFinalizado.treinoId = treinoId;
      treinoFinalizado.sincronizado = false;

      if(usuarioTreinosFinalizadosDispositivoJson == null){
        usuarioTreinosFinalizadosDispositivo = UsuarioTreinosFinalizados([], credenciais.id);
        usuarioTreinosFinalizadosDispositivo.treinos.add(treinoFinalizado);
      }
      else{
        usuarioTreinosFinalizadosDispositivo = UsuarioTreinosFinalizados.fromJson(usuarioTreinosFinalizadosDispositivoJson);
        usuarioTreinosFinalizadosDispositivo.treinos.add(treinoFinalizado);
      }
      
    }

    await _gravarTreinosFinalizadoNoDispositivo(usuarioTreinosFinalizadosDispositivo, credenciais.id);

    return treinoFinalizado;
  }

  Future<void> postTreinoNovo(List<TreinoExerciciosRequest> exercicios, String nomeTreino) async{
    await postTreino(exercicios, nomeTreino, null, false);
  }

  Future<void> postTreino(List<TreinoExerciciosRequest> exercicios, String nomeTreino, int? treinoId, bool isUpdate) async{

    var credenciais = await _retornarCredenciais();
    
    UsuarioTreinosRequest request = UsuarioTreinosRequest(credenciais.id,nomeTreino, exercicios, treinoId);

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
     

       if(treinosDispositivo != null){
        usuarioTreinos = UsuarioTreinos.fromJson(treinosDispositivo);
        bool encontrouTreino = false;
        //Fazer lógica se tiver o mesmo Usuarioid, treino Id e nome só da update no registro
        for(var treino in usuarioTreinos.treinos){
          if(treino.treinoId == treinoId && (treino.nomeTreino == nomeTreino || isUpdate) && treino.usuarioId == credenciais.id){ //Ao invés de usar o nome, criar um id proprio do registro salvo no dispoositivo
            treino.exercicios = novoTreinoResponse.exercicios;
            treino.nomeTreino = novoTreinoResponse.nomeTreino;
            treino.treinoId = novoTreinoResponse.treinoId;
            encontrouTreino = true;
          }
        }
        if(!encontrouTreino){
           UsuarioTreinosResponse novoTreino = UsuarioTreinosResponse(credenciais.id,novoTreinoResponse.treinoId,nomeTreino,exerciciosNovo);
        
          usuarioTreinos.treinos.add(novoTreino);
        }
       
      }
      else{
        List<UsuarioTreinosResponse> novoListaTreinos = [];
        UsuarioTreinosResponse novoTreino = UsuarioTreinosResponse(credenciais.id,novoTreinoResponse.treinoId,nomeTreino,exerciciosNovo);
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

        TreinoExerciciosResponse exercicioNovo = TreinoExerciciosResponse(exercicio.exercicioId, exercicio.foto,exercicio.nome!,seriesNovas);
        exerciciosNovo.add(exercicioNovo);
      }

      //Tipo dos treinos salvos no dispositivo
      UsuarioTreinosResponse novoTreino = UsuarioTreinosResponse(credenciais.id,treinoId,nomeTreino,exerciciosNovo);

      if(treinosDispositivo != null){
        usuarioTreinos = UsuarioTreinos.fromJson(treinosDispositivo);

        bool encontrouTreino = false;
        //Fazer lógica se tiver o mesmo Usuarioid e treino Id só da update no registro
        for(var treino in usuarioTreinos.treinos){
          if(treino.treinoId == treinoId && (treino.nomeTreino == nomeTreino || isUpdate) && treino.usuarioId == credenciais.id){
            treino.exercicios = exerciciosNovo;
            treino.nomeTreino = nomeTreino;
            encontrouTreino = true;
          }
        }
        if(!encontrouTreino){
          UsuarioTreinosResponse novoTreino = UsuarioTreinosResponse(credenciais.id,treinoId,nomeTreino,exerciciosNovo);
        
          usuarioTreinos.treinos.add(novoTreino);
        }
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

  Future<void> _gravarTreinosFinalizadoNoDispositivo (UsuarioTreinosFinalizados usuarioTreinos, int idUsuario) async{
    Store.salvarValor("treinosIndividuaisFinalizados#$idUsuario", usuarioTreinos.toJson());
  }


  Future<Map<String,dynamic>?> _retornarTreinosFinalizadoNoDispositivo (int idUsuario) async{
    return Store.retornarValor("treinosIndividuaisFinalizados#$idUsuario");
  }

  

}