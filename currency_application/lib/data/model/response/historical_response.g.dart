// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalResponse _$HistoricalResponseFromJson(Map<String, dynamic> json) =>
    HistoricalResponse()
      ..status = json['status'] as bool?
      ..error = json['error'] as String?
      ..data = json;

Map<String, dynamic> _$HistoricalResponseToJson(HistoricalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'data': instance.data,
    };
