import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_squad_front_end/clients/dio_client.dart';
import 'package:gym_squad_front_end/exceptions/unauthorized_exception.dart';
import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_request.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/solicitacoes_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/register_request.dart';
import 'package:gym_squad_front_end/models/api/solicitacoes/aceitar_solicitacao_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/store/store.dart';
import 'package:gym_squad_front_end/utils/api_codes_constants.dart';
import 'package:gym_squad_front_end/utils/api_routes.dart';

class ApiClient{
  final DioClient _dio = DioClient();

  Future<LoginResponse?> login(Map<String, dynamic> request) async {
    try {

      var response = await _dio.dio.post(
        ApiRoutes.login,
        data: request
      );

      return LoginResponse.fromJson(response.data);

    } on DioException catch (dioError) {
      if(dioError.response != null){
        if(dioError.response!.statusCode == ApiCodesConstants.semAutorizacao){
          throw UnauthorizedException(message: "Não foi possível fazer login com essas credenciais");
        }
      }else{
        throw Exception(dioError.message);
      }
      
    }
  }

  Future<Map<String, dynamic>?> refreshToken(String token, String refreshToken) async {
    try {
      
      Map<String, dynamic> request = {
        "AccessToken" : token,
        "RefreshToken" : refreshToken
      };

      var response = await _dio.dio.post(
        ApiRoutes.refreshToken,
        data: request
      );

      return response.data;

    } on DioException catch (dioError) {
      if(dioError.response != null){
        if(dioError.response!.statusCode == ApiCodesConstants.semAutorizacao){
          throw UnauthorizedException(message: "Não foi possível fazer login com essas credenciais");
        }
      }else{
        throw Exception(dioError.message);
      }
      
    }
  }

  Future<void> cadastrar(RegisterRequest request) async {
    try {

      var response = await _dio.dio.post(
        ApiRoutes.cadastro,
        data: request.toJson()
      );
    } on DioException catch (dioError) {
        throw Exception(dioError.response!.data["message"]);
    } on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<List<UsuarioTreinosResponse>> getTreinosByUserId(String token, int idUsuario) async {

    List<UsuarioTreinosResponse> retorno = [];
    try {

      var response = await _dio.dio.get(
        ApiRoutes.treinosInidividuaisUsuario + idUsuario.toString()

      );

      var responseData = response.data;

      for(var data in responseData){
        UsuarioTreinosResponse usuarioTreino = UsuarioTreinosResponse.fromJson(data);
        retorno.add(usuarioTreino);
      }

      return retorno;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }
  

  Future<List<UsuarioGrupoResponse>> getUsersByGrupoId(String token, int idGrupo) async {

    List<UsuarioGrupoResponse> retorno = [];
    try {

      var response = await _dio.dio.get(
        ApiRoutes.usuarioGruposGetByGrupoId + idGrupo.toString()

      );

      var responseData = response.data;

      for(var data in responseData){
        UsuarioGrupoResponse usuarioTreino = UsuarioGrupoResponse.fromJson(data);
        retorno.add(usuarioTreino);
      }

      return retorno;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<List<SolicitacoesResponse>> getSolicitacoesByGrupoId(int idGrupo) async {

    List<SolicitacoesResponse> retorno = [];
    try {

      var response = await _dio.dio.get(
        ApiRoutes.solicitacoesGetByGrupoId + idGrupo.toString()

      );

      var responseData = response.data;

      for(var data in responseData){
        SolicitacoesResponse solicitacao = SolicitacoesResponse.fromJson(data);
        retorno.add(solicitacao);
      }

      return retorno;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> deleteByGrupoIdAndUserId(String token, int idGrupo, int usuarioId) async {

      await _dio.dio.delete(
        "${ApiRoutes.usuarioGrupos} $usuarioId/${idGrupo.toString()}"

      );

  }

  Future<void> postGrupo(GrupoRequest request) async {

      await _dio.dio.post(
        ApiRoutes.usuarioGrupos,
        data: request.toJson()
      );

  }

  Future<void> aceitarSolicitacao(AceitarSolicitacaoRequest request) async {
    try {

      var response = await _dio.dio.post(
        ApiRoutes.solicitacoesAceitar,
        data: request.toJson()
      );
      
    } on DioException catch (dioError) {
        throw Exception(dioError.response!.data["message"]);
    } on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> rejeitarSolicitacao(AceitarSolicitacaoRequest request) async {
    try {

      var response = await _dio.dio.put(
        ApiRoutes.solicitacoesRecusar,
        data: request.toJson()
      );
      
    } on DioException catch (dioError) {
        throw Exception(dioError.response!.data["message"]);
    } on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<List<UsuarioGrupoResponse>> getGruposByUserId(String token, int idUsuario) async {

    List<UsuarioGrupoResponse> retorno = [];
    try {

      var response = await _dio.dio.get(
        ApiRoutes.usuarioGrupos + idUsuario.toString()

      );

      var responseData = response.data;

      for(var data in responseData){
        UsuarioGrupoResponse usuarioTreino = UsuarioGrupoResponse.fromJson(data);
        retorno.add(usuarioTreino);
      }

      return retorno;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> enviarSolicitacao(AceitarSolicitacaoRequest request) async {
    try {

      var response = await _dio.dio.post(
        ApiRoutes.solicitacoesEnviar,
        data: request.toJson()
      );
      
    } on DioException catch (dioError) {
        throw Exception(dioError.response!.data["message"]);
    } on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<void> deleteTreino(String token, int idTreino) async {

    try {
      await _dio.dio.delete(
        ApiRoutes.treinosInidividuaisUsuario + idTreino.toString()

      );

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<List< ExercicioResponse>> getAllExercicios(String token) async {

    List<ExercicioResponse> exercicios = [];

    try {

      var response = await _dio.dio.get(
        ApiRoutes.getAllExercicios
      );

      var responseData = response.data;

      for(var data in responseData){
        ExercicioResponse exercicio = ExercicioResponse.fromJson(data);

        exercicios.add(exercicio);
      }

      

      return exercicios;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<TreinoIniciadoResponse> postTreinoFinalizado(TreinoIniciadoRequest request, String token) async {

    try {

      var response = await _dio.dio.post(
        ApiRoutes.treinoFinalizado,
        data: request.toJson()
      );

      var retorno = TreinoIniciadoResponse.fromJson(response.data);

      return retorno;

    } on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<UsuarioTreinosResponse> postTreinoNovo(UsuarioTreinosRequest request, String token) async {
    try {


      var response = await _dio.dio.post(
        ApiRoutes.treinosInidividuaisUsuario,
        data: request.toJson()
      );

      var responseData = response.data;

      var retorno = UsuarioTreinosResponse.fromJson(responseData);

      return retorno;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

   Future<GrupoResponse> getGrupoByCodigo(int codigo) async {

    try {

      var response = await _dio.dio.get(
        ApiRoutes.grupoGetByCodigo + codigo.toString()

      );

      var responseData = GrupoResponse.fromJson(response.data);

      return responseData;

    }  on DioException catch (dioError){
      if(dioError.response != null){
        throw Exception( dioError.response!.data["message"]);
      }
      throw Exception(dioError.message);
      
    } on Exception catch(e){
      throw Exception(e.toString());
    }
  }

}

