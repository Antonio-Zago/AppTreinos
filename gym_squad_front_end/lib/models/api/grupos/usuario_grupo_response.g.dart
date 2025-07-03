// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_grupo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioGrupoResponse _$UsuarioGrupoResponseFromJson(
        Map<String, dynamic> json) =>
    UsuarioGrupoResponse(
      (json['usuarioId'] as num).toInt(),
      (json['grupoId'] as num).toInt(),
      json['ehAdmin'] as bool,
      json['nome'] as String,
      json['nomeUsuario'] as String?,
    );

Map<String, dynamic> _$UsuarioGrupoResponseToJson(
        UsuarioGrupoResponse instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'grupoId': instance.grupoId,
      'ehAdmin': instance.ehAdmin,
      'nome': instance.nome,
      'nomeUsuario': instance.nomeUsuario,
    };
