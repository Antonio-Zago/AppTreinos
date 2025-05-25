import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercicio_iniciado_response.g.dart';

@JsonSerializable()
class ExercicioIniciadoResponse{
  ExercicioIniciadoResponse(this.exercicioId, this.dadosTreinoExercicioSeries);

  final int exercicioId;
  final List<SerieIniciadoResponse> dadosTreinoExercicioSeries;

  factory ExercicioIniciadoResponse.fromJson(Map<String, dynamic> json) => _$ExercicioIniciadoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ExercicioIniciadoResponseToJson(this);
}