// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerieRequest _$SerieRequestFromJson(Map<String, dynamic> json) => SerieRequest(
      (json['repeticoes'] as num).toInt(),
      (json['carga'] as num).toDouble(),
    );

Map<String, dynamic> _$SerieRequestToJson(SerieRequest instance) =>
    <String, dynamic>{
      'repeticoes': instance.repeticoes,
      'carga': instance.carga,
    };
