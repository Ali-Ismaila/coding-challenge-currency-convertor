import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'currency_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrencyListResponse {
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'results')
  Map<String, dynamic>? data;

  static CurrencyListResponse fromJson(Map<String, dynamic> json) =>
      _$CurrencyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyListResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Currency {
  @JsonKey(name: 'currencyId')
  final String? currencyId;
  @JsonKey(name: 'currencyName')
  final String? currencyName;
  @JsonKey(name: 'currencySymbol')
  final String? currencySymbol;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;

  Currency(this.currencyId, this.currencyName, this.currencySymbol, this.id,
      this.name);

  static Currency fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
