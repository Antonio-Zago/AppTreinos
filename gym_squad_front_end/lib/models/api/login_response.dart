import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{
  LoginResponse(this.token, this.refreshToken, this.expiration, this.usuario, this.email, this.id, this.foto);

  String token;
  String refreshToken;
  final DateTime expiration;
  final String usuario;
  final String email;
  final int id;
  final String? foto;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}