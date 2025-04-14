import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercicio_iniciado_request.g.dart';

@JsonSerializable()
class ExercicioIniciadoRequest{
  ExercicioIniciadoRequest(this.exercicioId, this.dadosTreinoExercicioSeries);

  final int exercicioId;
  final List<SerieIniciadoRequest> dadosTreinoExercicioSeries;

  factory ExercicioIniciadoRequest.fromJson(Map<String, dynamic> json) => _$ExercicioIniciadoRequestFromJson(json);


  Map<String, dynamic> toJson() => _$ExercicioIniciadoRequestToJson(this);
}