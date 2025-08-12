// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario_treinos_finalizados.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsuarioTreinosFinalizados _$UsuarioTreinosFinalizadosFromJson(
        Map<String, dynamic> json) =>
    UsuarioTreinosFinalizados(
      (json['treinos'] as List<dynamic>)
          .map((e) => TreinoFinalizado.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['idUsuario'] as num).toInt(),
    );

Map<String, dynamic> _$UsuarioTreinosFinalizadosToJson(
        UsuarioTreinosFinalizados instance) =>
    <String, dynamic>{
      'idUsuario': instance.idUsuario,
      'treinos': instance.treinos,
    };
