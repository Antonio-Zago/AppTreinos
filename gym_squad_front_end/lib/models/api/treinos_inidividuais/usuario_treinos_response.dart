import 'package:gym_squad_front_end/models/api/treinos_inidividuais/treino_exercicios_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario_treinos_response.g.dart';

@JsonSerializable()
class UsuarioTreinosResponse{
  UsuarioTreinosResponse(this.usuarioId, this.treinoId, this.nomeTreino, this.exercicios);

  int usuarioId;
  int? treinoId;
  String nomeTreino;
  List<TreinoExerciciosResponse> exercicios;

  factory UsuarioTreinosResponse.fromJson(Map<String, dynamic> json) => _$UsuarioTreinosResponseFromJson(json);


  Map<String, dynamic> toJson() => _$UsuarioTreinosResponseToJson(this);
}