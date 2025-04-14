// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_iniciado_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerieIniciadoRequest _$SerieIniciadoRequestFromJson(
        Map<String, dynamic> json) =>
    SerieIniciadoRequest(
      (json['repeticoes'] as num).toInt(),
      (json['carga'] as num).toDouble(),
    );

Map<String, dynamic> _$SerieIniciadoRequestToJson(
        SerieIniciadoRequest instance) =>
    <String, dynamic>{
      'repeticoes': instance.repeticoes,
      'carga': instance.carga,
    };
