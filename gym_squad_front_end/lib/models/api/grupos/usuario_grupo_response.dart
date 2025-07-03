import 'package:json_annotation/json_annotation.dart';

part 'usuario_grupo_response.g.dart';

@JsonSerializable()
class UsuarioGrupoResponse{
  UsuarioGrupoResponse(this.usuarioId, this.grupoId, this.ehAdmin, this.nome, this.nomeUsuario);

  int usuarioId;
  int grupoId;
  bool ehAdmin;
  String nome;
  String? nomeUsuario;

  factory UsuarioGrupoResponse.fromJson(Map<String, dynamic> json) => _$UsuarioGrupoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$UsuarioGrupoResponseToJson(this);
}