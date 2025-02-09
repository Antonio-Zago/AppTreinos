import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest{
  LoginRequest(this.email, this.senha);

  final String email;
  final String senha;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);


  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}