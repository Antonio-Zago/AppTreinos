import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:gym_squad_front_end/models/memoria/serie_finalizado.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercicio_finalizado.g.dart';

@JsonSerializable()
class ExercicioFinalizado{
  ExercicioFinalizado();

  int? exercicioId;
  String? exercicioNome;
  List<SerieFinalizado>? dadosTreinoExercicioSeries;

  factory ExercicioFinalizado.fromJson(Map<String, dynamic> json) => _$ExercicioFinalizadoFromJson(json);


  Map<String, dynamic> toJson() => _$ExercicioFinalizadoToJson(this);
}