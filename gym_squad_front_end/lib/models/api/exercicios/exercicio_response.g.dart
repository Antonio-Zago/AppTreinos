// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercicio_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercicioResponse _$ExercicioResponseFromJson(Map<String, dynamic> json) =>
    ExercicioResponse(
      (json['id'] as num).toInt(),
      json['nome'] as String,
      json['foto'] as String?,
    );

Map<String, dynamic> _$ExercicioResponseToJson(ExercicioResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'foto': instance.foto,
    };
