import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treino_iniciado_request.g.dart';

@JsonSerializable()
class TreinoIniciadoRequest{
  TreinoIniciadoRequest(this.usuarioId, this.treinoId, this.exercicios);

  final int usuarioId;
  final int treinoId;
  final List<ExercicioIniciadoRequest> exercicios;

  factory TreinoIniciadoRequest.fromJson(Map<String, dynamic> json) => _$TreinoIniciadoRequestFromJson(json);


  Map<String, dynamic> toJson() => _$TreinoIniciadoRequestToJson(this);
}