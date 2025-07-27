// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicacao_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicacaoResponse _$PublicacaoResponseFromJson(Map<String, dynamic> json) =>
    PublicacaoResponse(
      json['titulo'] as String,
      json['descricao'] as String,
      (json['codigoGrupo'] as num).toInt(),
      (json['usuarioId'] as num).toInt(),
      (json['id'] as num).toInt(),
      DateTime.parse(json['dataHora'] as String),
      json['foto'] as String?,
      json['nomeUsuario'] as String,
    );

Map<String, dynamic> _$PublicacaoResponseToJson(PublicacaoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titulo': instance.titulo,
      'descricao': instance.descricao,
      'codigoGrupo': instance.codigoGrupo,
      'usuarioId': instance.usuarioId,
      'dataHora': instance.dataHora.toIso8601String(),
      'foto': instance.foto,
      'nomeUsuario': instance.nomeUsuario,
    };
