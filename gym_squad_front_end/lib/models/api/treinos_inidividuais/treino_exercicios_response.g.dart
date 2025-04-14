// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treino_exercicios_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreinoExerciciosResponse _$TreinoExerciciosResponseFromJson(
        Map<String, dynamic> json) =>
    TreinoExerciciosResponse(
      (json['id'] as num).toInt(),
      json['foto'] as String?,
      json['nome'] as String,
      (json['series'] as List<dynamic>)
          .map((e) => SerieResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TreinoExerciciosResponseToJson(
        TreinoExerciciosResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'foto': instance.foto,
      'nome': instance.nome,
      'series': instance.series,
    };
