import 'package:gym_squad_front_end/models/api/grupos/publicacao_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publicacao_paginacao_response.g.dart';

@JsonSerializable()
class PublicacaoPaginacaoResponse{
  PublicacaoPaginacaoResponse(this.totalRegistros, this.totalPaginas, this.dados);

  final int totalRegistros;
  final int totalPaginas;
  final List<PublicacaoResponse> dados;

  factory PublicacaoPaginacaoResponse.fromJson(Map<String, dynamic> json) => _$PublicacaoPaginacaoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$PublicacaoPaginacaoResponseToJson(this);
}