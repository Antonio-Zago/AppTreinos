// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_treinos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioTreinos _$UsuarioTreinosFromJson(Map<String, dynamic> json) =>
    UsuarioTreinos(
      (json['treinos'] as List<dynamic>)
          .map(
              (e) => UsuarioTreinosResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsuarioTreinosToJson(UsuarioTreinos instance) =>
    <String, dynamic>{
      'treinos': instance.treinos,
    };
