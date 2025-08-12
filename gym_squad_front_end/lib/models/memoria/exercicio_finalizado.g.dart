// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercicio_finalizado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercicioFinalizado _$ExercicioFinalizadoFromJson(Map<String, dynamic> json) =>
    ExercicioFinalizado()
      ..exercicioId = (json['exercicioId'] as num?)?.toInt()
      ..exercicioNome = json['exercicioNome'] as String?
      ..dadosTreinoExercicioSeries =
          (json['dadosTreinoExercicioSeries'] as List<dynamic>?)
              ?.map((e) => SerieFinalizado.fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$ExercicioFinalizadoToJson(
        ExercicioFinalizado instance) =>
    <String, dynamic>{
      'exercicioId': instance.exercicioId,
      'exercicioNome': instance.exercicioNome,
      'dadosTreinoExercicioSeries': instance.dadosTreinoExercicioSeries,
    };
