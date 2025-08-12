import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/treino_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/usuario_treinos_response.dart';
import 'package:gym_squad_front_end/models/memoria/treino_finalizado.dart';
import 'package:json_annotation/json_annotation.dart';

part 'usuario_treinos_finalizados.g.dart';

@JsonSerializable()
class UsuarioTreinosFinalizados{
  UsuarioTreinosFinalizados(this.treinos, this.idUsuario);

  final int idUsuario;
  List<TreinoFinalizado> treinos;

  factory UsuarioTreinosFinalizados.fromJson(Map<String, dynamic> json) => _$UsuarioTreinosFinalizadosFromJson(json);


  Map<String, dynamic> toJson() => _$UsuarioTreinosFinalizadosToJson(this);
}