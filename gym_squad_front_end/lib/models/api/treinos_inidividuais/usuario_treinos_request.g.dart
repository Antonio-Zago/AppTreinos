// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_treinos_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioTreinosRequest _$UsuarioTreinosRequestFromJson(
        Map<String, dynamic> json) =>
    UsuarioTreinosRequest(
      (json['usuarioId'] as num).toInt(),
      json['nomeTreino'] as String,
      (json['exercicios'] as List<dynamic>)
          .map((e) =>
              TreinoExerciciosRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['treinoId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UsuarioTreinosRequestToJson(
        UsuarioTreinosRequest instance) =>
    <String, dynamic>{
      'usuarioId': instance.usuarioId,
      'treinoId': instance.treinoId,
      'nomeTreino': instance.nomeTreino,
      'exercicios': instance.exercicios,
    };
