import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'convert_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ConvertResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'error')
  String? error;
  Map<String, double>? data;

  static ConvertResponse fromJson(Map<String, dynamic> json) =>
      _$ConvertResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConvertResponseToJson(this);
}
