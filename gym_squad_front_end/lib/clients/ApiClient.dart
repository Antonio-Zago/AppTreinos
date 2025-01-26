import 'dart:convert';
import 'package:dio/dio.dart';

class ApiClient{
  final Dio dio = Dio();
  final String _baseUrl = 'https://10.0.2.2:7176/auth/login';

  Future<void> login() async {
    try {

      var data = {
        "email": "admin@email",
        "senha":"1"
      };

      final response = await dio.post(
        _baseUrl,
        data: jsonEncode(data)
      );

      if (response.statusCode == 200) {

      } else {
        throw Exception('Erro ao obter games: Código ${response.statusCode}');
      }
    } on DioError catch (dioError) {
      throw Exception('Erro ao fazer a requisição: ${dioError.message}');
    }
  }
}

