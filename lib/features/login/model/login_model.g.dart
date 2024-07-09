// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginModelImpl _$$LoginModelImplFromJson(Map<String, dynamic> json) =>
    _$LoginModelImpl(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      password: json['password'] as String? ?? '',
      imgUrl: json['imgUrl'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      deviceToken: json['deviceToken'] as String? ?? '',
    );

Map<String, dynamic> _$$LoginModelImplToJson(_$LoginModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'dob': instance.dob,
      'password': instance.password,
      'imgUrl': instance.imgUrl,
      'userId': instance.userId,
      'deviceToken': instance.deviceToken,
    };
