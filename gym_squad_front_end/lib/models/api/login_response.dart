import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{
  LoginResponse(this.token, this.refreshToken, this.expiration, this.usuario, this.email, this.id);

  String token;
  String refreshToken;
  final DateTime expiration;
  final String usuario;
  final String email;
  final int id;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);


  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}