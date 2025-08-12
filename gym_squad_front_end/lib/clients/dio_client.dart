import 'package:dio/dio.dart';
import 'package:gym_squad_front_end/interceptors/auth_interceptor.dart';
import 'package:gym_squad_front_end/utils/api_routes.dart';

class DioClient {
  DioClient() {
    addInterceptor(LogInterceptor());
    addInterceptor(AuthInterceptor(dio));
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: ApiRoutes.urlBase),
  );

  void addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

}