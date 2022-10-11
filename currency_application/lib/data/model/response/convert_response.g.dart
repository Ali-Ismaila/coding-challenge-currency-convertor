// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertResponse _$ConvertResponseFromJson(Map<String, dynamic> json) =>
    ConvertResponse()
      ..status = json['status'] as bool?
      ..error = json['error'] as String?
      ..data = (json).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      );

Map<String, dynamic> _$ConvertResponseToJson(ConvertResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'data': instance.data,
    };
