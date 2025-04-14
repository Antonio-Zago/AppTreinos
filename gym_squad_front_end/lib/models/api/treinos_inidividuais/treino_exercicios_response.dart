import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treino_exercicios_response.g.dart';

@JsonSerializable()
class TreinoExerciciosResponse{
  TreinoExerciciosResponse(this.id, this.foto, this.nome, this.series);

  final int id;
  final String? foto;
  final String nome;
  final List<SerieResponse> series;

  factory TreinoExerciciosResponse.fromJson(Map<String, dynamic> json) => _$TreinoExerciciosResponseFromJson(json);


  Map<String, dynamic> toJson() => _$TreinoExerciciosResponseToJson(this);
}