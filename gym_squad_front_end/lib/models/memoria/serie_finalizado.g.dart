// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_finalizado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerieFinalizado _$SerieFinalizadoFromJson(Map<String, dynamic> json) =>
    SerieFinalizado()
      ..repeticoes = (json['repeticoes'] as num?)?.toInt()
      ..carga = (json['carga'] as num?)?.toDouble();

Map<String, dynamic> _$SerieFinalizadoToJson(SerieFinalizado instance) =>
    <String, dynamic>{
      'repeticoes': instance.repeticoes,
      'carga': instance.carga,
    };
