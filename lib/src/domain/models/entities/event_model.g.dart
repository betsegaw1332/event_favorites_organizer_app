// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  date: DateTime.parse(json['date'] as String),
  imageUrl: const AssetImageUrlConverter().fromJson(
    json['image_url'] as String,
  ),
);
