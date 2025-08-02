import 'package:gym_squad_front_end/clients/api_client.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_request.dart';
import 'package:gym_squad_front_end/models/api/grupos/grupo_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/publicacao_paginacao_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/publicacao_request.dart';
import 'package:gym_squad_front_end/models/api/grupos/publicacao_response.dart';
import 'package:gym_squad_front_end/models/api/grupos/ranking_response.dart';
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

  Future<void> postarPublicacoes(String titulo, String descricao, List<int> codigosGrupos, String base64String) async{
    var credenciais = await _retornarCredenciais();

    for(var codigo in codigosGrupos){
      PublicacaoRequest request = PublicacaoRequest(titulo, descricao,codigo,credenciais.id, base64String);

      await apiClient.postarPublicacao(request);
    }

  }

  Future<List<UsuarioGrupoResponse>> getUsersByGrupoId(int grupoId) async{
    var credenciais = await _retornarCredenciais();

    var grupos = await apiClient.getUsersByGrupoId(credenciais.token, grupoId);

    return grupos;
  }

  Future<PublicacaoPaginacaoResponse> getPublicacoesByGrupoId(int grupoId, int page) async{

    var publicacoes = await apiClient.getPublicacoesByGrupoId(grupoId, page);

    return publicacoes;
  }

  Future<List<SolicitacoesResponse>> getSolicitacoesByGrupoId(int grupoId) async{

    var grupos = await apiClient.getSolicitacoesByGrupoId(grupoId);

    return grupos;
  }

  Future<List<RankingResponse>> getRankingByCodigoGrupo(int codigo, int index) async{

    DateTime inicio;
    DateTime fim;
    var dataAtual = DateTime.now();

    if(index == 0){ //Semana
      var diaSemanaAtual = dataAtual.weekday;
      inicio = dataAtual.add(Duration(days: - diaSemanaAtual));
      fim = dataAtual;
    }
    else if(index == 1){ //Mês
      
      inicio = DateTime(dataAtual.year,dataAtual.month,1);
      fim = dataAtual;
    }
    else{ //Sempre
      inicio =  DateTime(2000, 1, 1);
      fim = dataAtual;
    }

    var grupos = await apiClient.getRankingByCodigoGrupo(codigo, inicio, fim);

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