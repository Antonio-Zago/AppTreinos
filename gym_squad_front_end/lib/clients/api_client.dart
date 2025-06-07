import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_squad_front_end/exceptions/unauthorized_exception.dart';
import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/register_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/store/store.dart';
import 'package:gym_squad_front_end/utils/api_codes_constants.dart';
import 'package:gym_squad_front_end/utils/api_routes.dart';

class ApiClient{
  final Dio _dio = Dio();

  Future<LoginResponse?> login(Map<String, dynamic> request) async {
    try {

      var response = await _dio.post(
        ApiRoutes.urlBase + ApiRoutes.login,
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

  Future<void> cadastrar(RegisterRequest request) async {
    try {

      var response = await _dio.post(
        ApiRoutes.urlBase + ApiRoutes.cadastro,
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


      _dio.options.headers = {
        'Authorization': 'Bearer $token',  // Adiciona o token no cabeçalho
        'Accept': 'application/json',
      };

      var response = await _dio.get(
        ApiRoutes.urlBase + ApiRoutes.treinosInidividuaisUsuario + idUsuario.toString()

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

  Future<void> deleteTreino(String token, int idTreino) async {

    try {
      _dio.options.headers = {
        'Authorization': 'Bearer $token',  // Adiciona o token no cabeçalho
        'Accept': 'application/json',
      };

      await _dio.delete(
        ApiRoutes.urlBase + ApiRoutes.treinosInidividuaisUsuario + idTreino.toString()

      );

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

  Future<List< ExercicioResponse>> getAllExercicios(String token) async {

    List<ExercicioResponse> exercicios = [];

    try {
      _dio.options.headers = {
        'Authorization': 'Bearer $token',  // Adiciona o token no cabeçalho
        'Accept': 'application/json',
      };

      var response = await _dio.get(
        ApiRoutes.urlBase + ApiRoutes.getAllExercicios
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

      _dio.options.headers = {
        'Authorization': 'Bearer $token',  // Adiciona o token no cabeçalho
        'Accept': 'application/json',
      };

      var response = await _dio.post(
        ApiRoutes.urlBase + ApiRoutes.treinoFinalizado,
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

      _dio.options.headers = {
        'Authorization': 'Bearer $token',  // Adiciona o token no cabeçalho
        'Accept': 'application/json',
      };

      var response = await _dio.post(
        ApiRoutes.urlBase + ApiRoutes.treinosInidividuaisUsuario,
        data: request.toJson()
      );

      var responseData = response.data;

      var retorno = UsuarioTreinosResponse.fromJson(responseData);

      return retorno;

    }  on Exception catch (e){
      throw Exception(e.toString());
    }
  }

}

