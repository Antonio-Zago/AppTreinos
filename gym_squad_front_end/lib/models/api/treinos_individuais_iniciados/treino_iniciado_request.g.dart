// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treino_iniciado_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreinoIniciadoRequest _$TreinoIniciadoRequestFromJson(
        Map<String, dynamic> json) =>
    TreinoIniciadoRequest(
      (json['usuarioId'] as num).toInt(),
      (json['treinoId'] as num).toInt(),
      (json['exercicios'] as List<dynamic>)
          .map((e) =>
              ExercicioIniciadoRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TreinoIniciadoRequestToJson(
        TreinoIniciadoRequest instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'treinoId': instance.treinoId,
      'exercicios': instance.exercicios,
    };
