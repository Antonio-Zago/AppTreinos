// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicacao_paginacao_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicacaoPaginacaoResponse _$PublicacaoPaginacaoResponseFromJson(
        Map<String, dynamic> json) =>
    PublicacaoPaginacaoResponse(
      (json['totalRegistros'] as num).toInt(),
      (json['totalPaginas'] as num).toInt(),
      (json['dados'] as List<dynamic>)
          .map((e) => PublicacaoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PublicacaoPaginacaoResponseToJson(
        PublicacaoPaginacaoResponse instance) =>
    <String, dynamic>{
      'totalRegistros': instance.totalRegistros,
      'totalPaginas': instance.totalPaginas,
      'dados': instance.dados,
    };
