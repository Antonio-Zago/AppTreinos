import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serie_finalizado.g.dart';

@JsonSerializable()
class SerieFinalizado{
  SerieFinalizado();

  int? repeticoes;
  double? carga;

  factory SerieFinalizado.fromJson(Map<String, dynamic> json) => _$SerieFinalizadoFromJson(json);


  Map<String, dynamic> toJson() => _$SerieFinalizadoToJson(this);
}