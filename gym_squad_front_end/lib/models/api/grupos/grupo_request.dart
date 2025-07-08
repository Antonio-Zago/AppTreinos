import 'package:json_annotation/json_annotation.dart';

part 'grupo_request.g.dart';

@JsonSerializable()
class GrupoRequest{
  GrupoRequest(this.usuarioId, this.nome);

  int usuarioId;
  String nome;

  factory GrupoRequest.fromJson(Map<String, dynamic> json) => _$GrupoRequestFromJson(json);


  Map<String, dynamic> toJson() => _$GrupoRequestToJson(this);
}