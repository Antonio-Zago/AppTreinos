import 'package:json_annotation/json_annotation.dart';

part 'serie_response.g.dart';

@JsonSerializable()
class SerieResponse{
  SerieResponse(this.repeticoes, this.carga);

  final int repeticoes;
  final double carga;

  factory SerieResponse.fromJson(Map<String, dynamic> json) => _$SerieResponseFromJson(json);


  Map<String, dynamic> toJson() => _$SerieResponseToJson(this);
}