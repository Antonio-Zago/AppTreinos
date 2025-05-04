import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercicio_response.g.dart';

@JsonSerializable()
class ExercicioResponse{
  ExercicioResponse(this.id, this.nome, this.foto);

  final int id;
  final String nome;
  final String? foto;

  factory ExercicioResponse.fromJson(Map<String, dynamic> json) => _$ExercicioResponseFromJson(json);


  Map<String, dynamic> toJson() => _$ExercicioResponseToJson(this);
}