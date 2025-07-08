// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupo_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrupoRequest _$GrupoRequestFromJson(Map<String, dynamic> json) => GrupoRequest(
      (json['usuarioId'] as num).toInt(),
      json['nome'] as String,
    );

Map<String, dynamic> _$GrupoRequestToJson(GrupoRequest instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'nome': instance.nome,
    };
