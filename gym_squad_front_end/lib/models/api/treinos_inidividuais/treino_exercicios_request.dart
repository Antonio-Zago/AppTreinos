import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treino_exercicios_request.g.dart';

@JsonSerializable()
class TreinoExerciciosRequest{
  TreinoExerciciosRequest(this.exercicioId, this.series, this.foto, this.nome);

  final int exercicioId;
  final String? foto;
  final String? nome;
  final List<SerieRequest> series;

  factory TreinoExerciciosRequest.fromJson(Map<String, dynamic> json) => _$TreinoExerciciosRequestFromJson(json);


  Map<String, dynamic> toJson() => _$TreinoExerciciosRequestToJson(this);
}