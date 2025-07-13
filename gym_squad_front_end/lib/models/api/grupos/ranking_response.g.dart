// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RankingResponse _$RankingResponseFromJson(Map<String, dynamic> json) =>
    RankingResponse(
      json['nomeUsuario'] as String,
      (json['quantidade'] as num).toInt(),
    );

Map<String, dynamic> _$RankingResponseToJson(RankingResponse instance) =>
    <String, dynamic>{
      'nomeUsuario': instance.nomeUsuario,
      'quantidade': instance.quantidade,
    };
