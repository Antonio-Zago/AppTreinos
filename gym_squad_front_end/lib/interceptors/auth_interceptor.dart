import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/business/auth_service.dart';
import 'package:gym_squad_front_end/business/login_business.dart';
import 'package:gym_squad_front_end/clients/dio_client.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/store/store.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {

  final Dio dio;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options, RequestInterceptorHandler handler) async {

    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    if(credenciais != null){
       var credenciaisResponse = LoginResponse.fromJson(credenciais!);

      var token = credenciaisResponse.token;

      options.headers.addAll({'Authorization': 'Bearer $token'});
      
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    
    LoginBusiness loginBusiness = LoginBusiness();
    if(err.response != null){
      if(err.response!.statusCode == 401){
        

        try {
          await loginBusiness.refreshToken();
          handler.resolve( await _retry(err.requestOptions));
          return;
        } on DioException catch ( e ) {
          if (e.response?.statusCode == 400) {
            // Refresh token inválido → redireciona
            AuthService().logoutAndRedirect();
          }
          // Se a solicitação falhar novamente, passe o erro para o próximo interceptor na cadeia.
          handler.next(e);
          return;
        } 
        
      }
      // Passe o erro para o próximo interceptor na cadeia.
     handler.next(err);
     return;
    }
    

    super.onError(err, handler);
  }


  Future<Response< dynamic >> _retry(RequestOptions requestOptions) async { 
    // Cria um novo objeto `RequestOptions` com o mesmo método, caminho, dados e parâmetros de consulta da solicitação original. 

    // Tenta novamente a solicitação com o novo objeto `RequestOptions`. 
    return dio.request< dynamic >(requestOptions.path, 
        data : requestOptions. data , 
        queryParameters: requestOptions.queryParameters); 
  }
}