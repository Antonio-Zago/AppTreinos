import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serie_iniciado_request.g.dart';

@JsonSerializable()
class SerieIniciadoRequest{
  SerieIniciadoRequest(this.repeticoes, this.carga);

  final int repeticoes;
  final double carga;

  factory SerieIniciadoRequest.fromJson(Map<String, dynamic> json) => _$SerieIniciadoRequestFromJson(json);


  Map<String, dynamic> toJson() => _$SerieIniciadoRequestToJson(this);
}