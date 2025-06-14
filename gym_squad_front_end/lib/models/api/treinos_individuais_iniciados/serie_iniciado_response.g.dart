// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_iniciado_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerieIniciadoResponse _$SerieIniciadoResponseFromJson(
        Map<String, dynamic> json) =>
    SerieIniciadoResponse(
      (json['repeticoes'] as num).toInt(),
      (json['carga'] as num).toDouble(),
      (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SerieIniciadoResponseToJson(
        SerieIniciadoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'repeticoes': instance.repeticoes,
      'carga': instance.carga,
    };
