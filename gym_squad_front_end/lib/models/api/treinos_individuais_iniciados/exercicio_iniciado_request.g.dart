// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercicio_iniciado_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercicioIniciadoRequest _$ExercicioIniciadoRequestFromJson(
        Map<String, dynamic> json) =>
    ExercicioIniciadoRequest(
      (json['exercicioId'] as num).toInt(),
      (json['dadosTreinoExercicioSeries'] as List<dynamic>)
          .map((e) => SerieIniciadoRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['exercicioNome'] as String,
    );

Map<String, dynamic> _$ExercicioIniciadoRequestToJson(
        ExercicioIniciadoRequest instance) =>
    <String, dynamic>{
      'exercicioId': instance.exercicioId,
      'exercicioNome': instance.exercicioNome,
      'dadosTreinoExercicioSeries': instance.dadosTreinoExercicioSeries,
    };
