// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyListResponse _$CurrencyListResponseFromJson(
        Map<String, dynamic> json) =>
    CurrencyListResponse()
      ..status = json['status'] as bool?
      ..error = json['error'] as String?
      ..data = json['results'] as Map<String, dynamic>?;

Map<String, dynamic> _$CurrencyListResponseToJson(
        CurrencyListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'results': instance.data,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      json['currencyId'] as String?,
      json['currencyName'] as String?,
      json['currencySymbol'] as String?,
      json['id'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'currencySymbol': instance.currencySymbol,
      'id': instance.id,
      'name': instance.name,
    };
