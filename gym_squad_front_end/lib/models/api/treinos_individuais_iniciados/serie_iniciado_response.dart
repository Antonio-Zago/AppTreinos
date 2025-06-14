import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serie_iniciado_response.g.dart';

@JsonSerializable()
class SerieIniciadoResponse{
  SerieIniciadoResponse(this.repeticoes, this.carga, this.id);

  final int? id;
  final int repeticoes;
  final double carga;

  factory SerieIniciadoResponse.fromJson(Map<String, dynamic> json) => _$SerieIniciadoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$SerieIniciadoResponseToJson(this);
}