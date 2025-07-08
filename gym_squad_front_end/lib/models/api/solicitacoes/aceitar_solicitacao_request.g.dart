// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aceitar_solicitacao_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AceitarSolicitacaoRequest _$AceitarSolicitacaoRequestFromJson(
        Map<String, dynamic> json) =>
    AceitarSolicitacaoRequest(
      (json['usuarioId'] as num).toInt(),
      (json['codigoGrupo'] as num).toInt(),
    );

Map<String, dynamic> _$AceitarSolicitacaoRequestToJson(
        AceitarSolicitacaoRequest instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'codigoGrupo': instance.codigoGrupo,
    };
