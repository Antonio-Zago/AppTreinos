import 'package:dio/dio.dart';
import 'package:gym_squad_front_end/business/login_business.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/store/store.dart';

class AuthInterceptor extends Interceptor {

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    var credenciaisResponse = LoginResponse.fromJson(credenciais!);

    var token = credenciaisResponse.token;

    options.headers.addAll({'Authorization': 'Bearer $token'});
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    
     LoginBusiness loginBusiness = LoginBusiness();

    if(err.response!.statusCode == 404){
      loginBusiness.refreshToken();
    }

    super.onError(err, handler);
  }
}