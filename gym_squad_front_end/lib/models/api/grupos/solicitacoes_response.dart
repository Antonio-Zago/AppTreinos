import 'package:json_annotation/json_annotation.dart';

part 'solicitacoes_response.g.dart';

@JsonSerializable()
class SolicitacoesResponse{
  SolicitacoesResponse(this.usuarioId, this.grupoId, this.status, this.dataHora, this.usuarioNome);

  int usuarioId;
  int grupoId;
  int status;
  DateTime dataHora;
  String? usuarioNome;

  factory SolicitacoesResponse.fromJson(Map<String, dynamic> json) => _$SolicitacoesResponseFromJson(json);


  Map<String, dynamic> toJson() => _$SolicitacoesResponseToJson(this);
}