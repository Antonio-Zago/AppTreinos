// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treino_finalizado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreinoFinalizado _$TreinoFinalizadoFromJson(Map<String, dynamic> json) =>
    TreinoFinalizado()
      ..sincronizado = json['sincronizado'] as bool?
      ..treinoId = (json['treinoId'] as num?)?.toInt()
      ..nomeTreino = json['nomeTreino'] as String?
      ..dataAtual = json['dataAtual'] == null
          ? null
          : DateTime.parse(json['dataAtual'] as String)
      ..exercicios = (json['exercicios'] as List<dynamic>?)
          ?.map((e) => ExercicioFinalizado.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$TreinoFinalizadoToJson(TreinoFinalizado instance) =>
    <String, dynamic>{
      'sincronizado': instance.sincronizado,
      'treinoId': instance.treinoId,
      'nomeTreino': instance.nomeTreino,
      'dataAtual': instance.dataAtual?.toIso8601String(),
      'exercicios': instance.exercicios,
    };
