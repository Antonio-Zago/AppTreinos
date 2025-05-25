// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treino_iniciado_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreinoIniciadoResponse _$TreinoIniciadoResponseFromJson(
        Map<String, dynamic> json) =>
    TreinoIniciadoResponse(
      (json['usuarioId'] as num).toInt(),
      (json['treinoId'] as num).toInt(),
      (json['exercicios'] as List<dynamic>)
          .map((e) =>
              ExercicioIniciadoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['id'] as num).toInt(),
      DateTime.parse(json['dataAtual'] as String),
    );

Map<String, dynamic> _$TreinoIniciadoResponseToJson(
        TreinoIniciadoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usuarioId': instance.usuarioId,
      'treinoId': instance.treinoId,
      'dataAtual': instance.dataAtual.toIso8601String(),
      'exercicios': instance.exercicios,
    };
