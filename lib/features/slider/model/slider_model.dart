import 'package:freezed_annotation/freezed_annotation.dart';

part 'slider_model.freezed.dart';
part 'slider_model.g.dart';

@freezed
class SliderModel with _$SliderModel {
  const factory SliderModel({
    @JsonKey(name: 'sliderId') @Default('') String? sliderId,
    @JsonKey(name: 'sliderUrl') @Default('') String? sliderUrl,
  }) = _SliderModel;

  factory SliderModel.fromJson(Map<String, dynamic> json) =>
      _$SliderModelFromJson(json);
}
