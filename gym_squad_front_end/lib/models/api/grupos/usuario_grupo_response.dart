import 'package:json_annotation/json_annotation.dart';

part 'usuario_grupo_response.g.dart';

@JsonSerializable()
class UsuarioGrupoResponse{
  UsuarioGrupoResponse(this.usuarioId, this.grupoId, this.ehAdmin, this.nome, this.nomeUsuario, this.codigo);

  int usuarioId;
  int grupoId;
  bool ehAdmin;
  String nome;
  String? nomeUsuario;
  int codigo;

  factory UsuarioGrupoResponse.fromJson(Map<String, dynamic> json) => _$UsuarioGrupoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$UsuarioGrupoResponseToJson(this);
}