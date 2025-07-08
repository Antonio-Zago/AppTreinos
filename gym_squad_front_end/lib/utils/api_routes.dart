class ApiRoutes {
  static const String urlBase = "https://192.168.0.108:7176/";
  static const String urlBaseFatec = "https://192.168.99.29:7176/";
  static const String login = "auth/login";
  static const String refreshToken = "auth/refresh-token";
  static const String cadastro = "auth/register";
  static const String treinoFinalizado = "DadosTreino/";
  static const String treinosInidividuaisUsuario = "UsuarioTreino/";
  static const String getAllExercicios = "exercicios/";
  static const String usuarioGrupos = "UsuarioGrupo/";
  static const String usuarioGruposGetByGrupoId = "UsuarioGrupo/GetByGrupoId/";
  static const String solicitacoesGetByGrupoId = "Solicitacoes/GetByGrupoId/";
  static const String solicitacoesAceitar = "Solicitacoes/AceitarSolicitacao/";
  static const String solicitacoesRecusar = "Solicitacoes/RecusarSolicitacao/";
  static const String solicitacoesEnviar = "Solicitacoes";
  static const String grupoGetByCodigo = "Grupo/";
}