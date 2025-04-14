// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_treinos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioTreinosResponse _$UsuarioTreinosResponseFromJson(
        Map<String, dynamic> json) =>
    UsuarioTreinosResponse(
      (json['usuarioId'] as num).toInt(),
      (json['treinoId'] as num).toInt(),
      json['nomeTreino'] as String,
      (json['exercicios'] as List<dynamic>)
          .map((e) =>
              TreinoExerciciosResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsuarioTreinosResponseToJson(
        UsuarioTreinosResponse instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'treinoId': instance.treinoId,
      'nomeTreino': instance.nomeTreino,
      'exercicios': instance.exercicios,
    };
