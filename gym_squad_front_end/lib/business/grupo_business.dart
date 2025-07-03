import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/grupos/solicitacoes_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/store/store.dart';

class GrupoBusiness {

   ApiClient apiClient = ApiClient();

  Future<List<UsuarioGrupoResponse>> getGruposByUserId() async{
    var credenciais = await _retornarCredenciais();

    var grupos = await apiClient.getGruposByUserId(credenciais.token, credenciais.id);

    return grupos;
  }

  Future<List<UsuarioGrupoResponse>> getUsersByGrupoId(int grupoId) async{
    var credenciais = await _retornarCredenciais();

    var grupos = await apiClient.getUsersByGrupoId(credenciais.token, grupoId);

    return grupos;
  }

  Future<List<SolicitacoesResponse>> getSolicitacoesByGrupoId(int grupoId) async{

    var grupos = await apiClient.getSolicitacoesByGrupoId(grupoId);

    return grupos;
  }

  Future<void> deleteByGrupoIdAndUserId(int grupoId, int usuarioId) async{
    var credenciais = await _retornarCredenciais();

    await apiClient.deleteByGrupoIdAndUserId(credenciais.token, grupoId,usuarioId);
  }

  Future<LoginResponse> _retornarCredenciais() async{
    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    return LoginResponse.fromJson(credenciais!);
  }
}