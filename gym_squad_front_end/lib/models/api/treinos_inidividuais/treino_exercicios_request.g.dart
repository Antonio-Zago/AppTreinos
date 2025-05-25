// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treino_exercicios_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreinoExerciciosRequest _$TreinoExerciciosRequestFromJson(
        Map<String, dynamic> json) =>
    TreinoExerciciosRequest(
      (json['exercicioId'] as num).toInt(),
      (json['series'] as List<dynamic>)
          .map((e) => SerieRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['foto'] as String?,
      json['nome'] as String?,
    );

Map<String, dynamic> _$TreinoExerciciosRequestToJson(
        TreinoExerciciosRequest instance) =>
    <String, dynamic>{
      'exercicioId': instance.exercicioId,
      'foto': instance.foto,
      'nome': instance.nome,
      'series': instance.series,
    };
