// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'id': instance.id,
      'message': instance.message,
      'created_at': instance.createdAt,
    };
