import 'package:json_annotation/json_annotation.dart';

part 'ranking_response.g.dart';

@JsonSerializable()
class RankingResponse{
  RankingResponse(this.nomeUsuario, this.quantidade);

  String nomeUsuario;
  int quantidade;

  factory RankingResponse.fromJson(Map<String, dynamic> json) => _$RankingResponseFromJson(json);


  Map<String, dynamic> toJson() => _$RankingResponseToJson(this);
}