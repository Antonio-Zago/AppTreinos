import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gym_squad_front_end/exceptions/unauthorized_exception.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/utils/api_codes_constants.dart';

class ApiClient{
  final Dio dio = Dio();
  final String _baseUrl = 'https://192.168.0.105:7176/auth/login';

  Future<LoginResponse?> login(Map<String, dynamic> request) async {
    try {

      var response = await dio.post(
        _baseUrl,
        data: request
      );

      return LoginResponse.fromJson(response.data);

    } on DioException catch (dioError) {
      if(dioError.response!.statusCode == ApiCodesConstants.semAutorizacao){
        throw UnauthorizedException(message: "Não foi possível fazer login com essas credenciais");
      }
    } on Exception catch (e){
      throw Exception(e.toString());
    }
  }
}

