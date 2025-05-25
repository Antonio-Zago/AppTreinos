// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercicio_iniciado_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercicioIniciadoResponse _$ExercicioIniciadoResponseFromJson(
        Map<String, dynamic> json) =>
    ExercicioIniciadoResponse(
      (json['exercicioId'] as num).toInt(),
      (json['dadosTreinoExercicioSeries'] as List<dynamic>)
          .map((e) => SerieIniciadoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExercicioIniciadoResponseToJson(
        ExercicioIniciadoResponse instance) =>
    <String, dynamic>{
      'exercicioId': instance.exercicioId,
      'dadosTreinoExercicioSeries': instance.dadosTreinoExercicioSeries,
    };
