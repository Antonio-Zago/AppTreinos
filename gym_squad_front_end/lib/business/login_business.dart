import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/login_request.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/register_request.dart';
import 'package:gym_squad_front_end/store/store.dart';

class LoginBusiness {

  ApiClient apiClient = ApiClient();

  Future<void> login(String email, String senha) async{

    try{
      LoginRequest loginRequest = LoginRequest(email, senha);

      LoginResponse? loginResponse = await apiClient.login(loginRequest.toJson());      

      await _salvarCredenciais(loginResponse);
    }on Exception catch(e){
      throw Exception(e.toString());
    }

  }

  Future<void> cadastrar(String email, String senha, String nome) async{

    RegisterRequest registerRequest = RegisterRequest(email, senha,nome);

    await apiClient.cadastrar(registerRequest);      

  }

  _salvarCredenciais(LoginResponse? loginResponse) async{
    await Store.salvarValor("Credenciais", loginResponse!.toJson());
  }

}