import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario_treinos.g.dart';

@JsonSerializable()
class UsuarioTreinos{
  UsuarioTreinos(this.treinos);

  List<UsuarioTreinosResponse> treinos;

  factory UsuarioTreinos.fromJson(Map<String, dynamic> json) => _$UsuarioTreinosFromJson(json);


  Map<String, dynamic> toJson() => _$UsuarioTreinosToJson(this);
}