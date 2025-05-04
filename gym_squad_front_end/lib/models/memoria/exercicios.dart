import 'package:gym_squad_front_end/models/api/exercicios/exercicio_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercicios.g.dart';

@JsonSerializable()
class Exercicios{
  Exercicios(this.exercicios);

  final List<ExercicioResponse> exercicios;

  factory Exercicios.fromJson(Map<String, dynamic> json) => _$ExerciciosFromJson(json);


  Map<String, dynamic> toJson() => _$ExerciciosToJson(this);
}