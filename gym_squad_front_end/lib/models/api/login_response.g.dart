// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['token'] as String,
      json['refreshToken'] as String,
      DateTime.parse(json['expiration'] as String),
      json['usuario'] as String,
      json['email'] as String,
      (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'expiration': instance.expiration.toIso8601String(),
      'usuario': instance.usuario,
      'email': instance.email,
      'id': instance.id,
    };
