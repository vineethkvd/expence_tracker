import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_model.freezed.dart';
part 'login_model.g.dart';
@freezed
class LoginModel with _$LoginModel{
  const factory LoginModel({
    @JsonKey(name: 'name') @Default('') String? name,
    @JsonKey(name: 'email') @Default('') String? email,
    @JsonKey(name: 'phone') @Default('') String? phone,
    @JsonKey(name: 'gender') @Default('') String? gender,
    @JsonKey(name: 'dob') @Default('') String? dob,
    @JsonKey(name: 'password') @Default('') String? password,
    @JsonKey(name: 'imgUrl') @Default('') String? imgUrl,
    @JsonKey(name: 'userId') @Default('') String? userId,
    @JsonKey(name: 'deviceToken') @Default('') String? deviceToken,
  }) = _LoginModel;

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
}