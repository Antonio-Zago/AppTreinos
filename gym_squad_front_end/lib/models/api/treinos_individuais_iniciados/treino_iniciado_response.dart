import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_request.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/exercicio_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_individuais_iniciados/serie_iniciado_response.dart';
import 'package:gym_squad_front_end/models/api/treinos_inidividuais/serie_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treino_iniciado_response.g.dart';

@JsonSerializable()
class TreinoIniciadoResponse{
  TreinoIniciadoResponse(this.usuarioId, this.treinoId, this.exercicios, this.id, this.dataAtual);

  final int? id;
  final int usuarioId;
  final int treinoId;

  @JsonKey(fromJson: _fromJsonIgnoreTimezone, toJson: _toJsonIso8601)
  final DateTime dataAtual;
  final List<ExercicioIniciadoResponse> exercicios;

  factory TreinoIniciadoResponse.fromJson(Map<String, dynamic> json) => _$TreinoIniciadoResponseFromJson(json);


  Map<String, dynamic> toJson() => _$TreinoIniciadoResponseToJson(this);

  static DateTime _fromJsonIgnoreTimezone(String date) {
    // Parse a string como UTC e volta ao fuso original
     final cleaned = date.replaceFirst(RegExp(r'([-+]\d{2}:\d{2})$'), '');
    return DateTime.parse(cleaned);
  }

  static String _toJsonIso8601(DateTime date) {
    return date.toIso8601String();
  }
}