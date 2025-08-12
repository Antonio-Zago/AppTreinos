import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/exercicio_finalizado.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treino_finalizado.g.dart';

@JsonSerializable()
class TreinoFinalizado{
  TreinoFinalizado();

  bool? sincronizado;
  int? treinoId;
  String? nomeTreino;
  DateTime? dataAtual;
  List<ExercicioFinalizado>? exercicios;

  factory TreinoFinalizado.fromJson(Map<String, dynamic> json) => _$TreinoFinalizadoFromJson(json);


  Map<String, dynamic> toJson() => _$TreinoFinalizadoToJson(this);
}