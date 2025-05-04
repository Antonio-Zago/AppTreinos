import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'serie_request.g.dart';

@JsonSerializable()
class SerieRequest{
  SerieRequest(
    this.repeticoes,
    this.carga, {
    TextEditingController? controllerReps,
    TextEditingController? controllerCarga,
  })  : controllerReps = controllerReps ?? TextEditingController(),
        controllerCarga = controllerCarga ?? TextEditingController();

  int repeticoes;
  double carga;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextEditingController controllerReps;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextEditingController controllerCarga;

  factory SerieRequest.fromJson(Map<String, dynamic> json) => _$SerieRequestFromJson(json);


  Map<String, dynamic> toJson() => _$SerieRequestToJson(this);
}