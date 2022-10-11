import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'historical_response.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoricalResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'error')
  String? error;
  Map<String, dynamic>? data;

  static HistoricalResponse fromJson(Map<String, dynamic> json) =>
      _$HistoricalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoricalResponseToJson(this);
}
