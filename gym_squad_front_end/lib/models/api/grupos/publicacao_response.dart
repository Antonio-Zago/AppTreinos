import 'package:json_annotation/json_annotation.dart';

part 'publicacao_response.g.dart';

@JsonSerializable()
class PublicacaoResponse{
  PublicacaoResponse(this.titulo, this.descricao, this.codigoGrupo, this.usuarioId, this.id, this.dataHora, this.foto, this.nomeUsuario);

  final int id;
  final String titulo;
  final String descricao;
  final int codigoGrupo;
  final int usuarioId;
  final DateTime dataHora;
  final String? foto;
  final String nomeUsuario;

  factory PublicacaoResponse.fromJson(Map<String, dynamic> json) => _$PublicacaoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$PublicacaoResponseToJson(this);
}