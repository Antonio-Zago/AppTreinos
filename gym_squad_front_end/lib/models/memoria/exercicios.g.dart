// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercicios.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercicios _$ExerciciosFromJson(Map<String, dynamic> json) => Exercicios(
      (json['exercicios'] as List<dynamic>)
          .map((e) => ExercicioResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExerciciosToJson(Exercicios instance) =>
    <String, dynamic>{
      'exercicios': instance.exercicios,
    };
