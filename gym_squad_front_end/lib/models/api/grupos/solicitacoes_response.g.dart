// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solicitacoes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolicitacoesResponse _$SolicitacoesResponseFromJson(
        Map<String, dynamic> json) =>
    SolicitacoesResponse(
      (json['usuarioId'] as num).toInt(),
      (json['grupoId'] as num).toInt(),
      (json['status'] as num).toInt(),
      DateTime.parse(json['dataHora'] as String),
      json['usuarioNome'] as String?,
    );

Map<String, dynamic> _$SolicitacoesResponseToJson(
        SolicitacoesResponse instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'grupoId': instance.grupoId,
      'status': instance.status,
      'dataHora': instance.dataHora.toIso8601String(),
      'usuarioNome': instance.usuarioNome,
    };
