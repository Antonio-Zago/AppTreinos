// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicacao_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicacaoRequest _$PublicacaoRequestFromJson(Map<String, dynamic> json) =>
    PublicacaoRequest(
      json['titulo'] as String,
      json['descricao'] as String,
      (json['codigoGrupo'] as num).toInt(),
      (json['usuarioId'] as num).toInt(),
    );

Map<String, dynamic> _$PublicacaoRequestToJson(PublicacaoRequest instance) =>
    <String, dynamic>{
      'titulo': instance.titulo,
      'descricao': instance.descricao,
      'codigoGrupo': instance.codigoGrupo,
      'usuarioId': instance.usuarioId,
    };
