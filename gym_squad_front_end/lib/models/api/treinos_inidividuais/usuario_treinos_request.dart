import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario_treinos_request.g.dart';

@JsonSerializable()
class UsuarioTreinosRequest{
  UsuarioTreinosRequest(this.usuarioId, this.nomeTreino, this.exercicios, this.treinoId, );

  final int usuarioId;
  final int? treinoId;
  final String nomeTreino;
  final List<TreinoExerciciosRequest> exercicios;

  factory UsuarioTreinosRequest.fromJson(Map<String, dynamic> json) => _$UsuarioTreinosRequestFromJson(json);


  Map<String, dynamic> toJson() => _$UsuarioTreinosRequestToJson(this);
}