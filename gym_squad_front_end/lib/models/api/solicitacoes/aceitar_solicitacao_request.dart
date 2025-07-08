import 'package:json_annotation/json_annotation.dart';

part 'aceitar_solicitacao_request.g.dart';

@JsonSerializable()
class AceitarSolicitacaoRequest{
  AceitarSolicitacaoRequest(this.usuarioId, this.codigoGrupo);

  int usuarioId;
  int codigoGrupo;

  factory AceitarSolicitacaoRequest.fromJson(Map<String, dynamic> json) => _$AceitarSolicitacaoRequestFromJson(json);


  Map<String, dynamic> toJson() => _$AceitarSolicitacaoRequestToJson(this);
}