import 'package:json_annotation/json_annotation.dart';

part 'grupo_response.g.dart';

@JsonSerializable()
class GrupoResponse{
  GrupoResponse(this.codigo, this.nome);

  int codigo;
  String nome;

  factory GrupoResponse.fromJson(Map<String, dynamic> json) => _$GrupoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$GrupoResponseToJson(this);
}