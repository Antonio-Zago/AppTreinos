// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grupo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrupoResponse _$GrupoResponseFromJson(Map<String, dynamic> json) =>
    GrupoResponse(
      (json['codigo'] as num).toInt(),
      json['nome'] as String,
    );

Map<String, dynamic> _$GrupoResponseToJson(GrupoResponse instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'nome': instance.nome,
    };
