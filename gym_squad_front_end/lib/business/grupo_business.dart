import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_request.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/solicitacoes_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/usuario_grupo_response.dart';
import 'package:gym_squad_front_end/models/api/login_response.dart';
import 'package:gym_squad_front_end/models/api/solicitacoes/aceitar_solicitacao_request.dart';
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

  Future<void> postGrupo(String nome) async{
    var credenciais = await _retornarCredenciais();

    GrupoRequest request = GrupoRequest(credenciais.id, nome);

    await apiClient.postGrupo(request);
  }

  Future<void> aceitarSolicitacao(int grupoId, int usuarioId) async{

    AceitarSolicitacaoRequest request = AceitarSolicitacaoRequest(usuarioId, grupoId);

    await apiClient.aceitarSolicitacao(request);
  }

  Future<void> rejeitarSolicitacao(int grupoId, int usuarioId) async{

    AceitarSolicitacaoRequest request = AceitarSolicitacaoRequest(usuarioId, grupoId);

    await apiClient.rejeitarSolicitacao(request);
  }

  Future<GrupoResponse> getGrupoByCodigo(int codigo) async{

    var grupo = await apiClient.getGrupoByCodigo(codigo);

    return grupo;
  }

  Future<void> enviarSolicitacao(int codigoGrupo) async{

    var credenciais = await _retornarCredenciais();

    AceitarSolicitacaoRequest request = AceitarSolicitacaoRequest(credenciais.id, codigoGrupo);

    await apiClient.enviarSolicitacao(request);
  }


  Future<LoginResponse> _retornarCredenciais() async{
    Map<String,dynamic>? credenciais = await Store.retornarValor("Credenciais");

    return LoginResponse.fromJson(credenciais!);
  }
}