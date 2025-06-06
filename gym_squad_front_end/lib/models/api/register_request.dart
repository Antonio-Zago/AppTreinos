import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest{
  RegisterRequest(this.email, this.senha, this.nome);

  final String email;
  final String senha;
  final String nome;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);


  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}