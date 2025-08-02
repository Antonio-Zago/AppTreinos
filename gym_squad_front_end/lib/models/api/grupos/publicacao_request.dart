import 'package:json_annotation/json_annotation.dart';

part 'publicacao_request.g.dart';

@JsonSerializable()
class PublicacaoRequest{
  PublicacaoRequest(this.titulo, this.descricao, this.codigoGrupo, this.usuarioId, this.foto);

  final String titulo;
  final String descricao;
  final int codigoGrupo;
  final int usuarioId;
  final String foto;

  factory PublicacaoRequest.fromJson(Map<String, dynamic> json) => _$PublicacaoRequestFromJson(json);


  Map<String, dynamic> toJson() => _$PublicacaoRequestToJson(this);
}