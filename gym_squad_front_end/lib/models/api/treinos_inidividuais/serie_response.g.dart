// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerieResponse _$SerieResponseFromJson(Map<String, dynamic> json) =>
    SerieResponse(
      (json['repeticoes'] as num).toInt(),
      (json['carga'] as num).toDouble(),
    );

Map<String, dynamic> _$SerieResponseToJson(SerieResponse instance) =>
    <String, dynamic>{
      'repeticoes': instance.repeticoes,
      'carga': instance.carga,
    };
