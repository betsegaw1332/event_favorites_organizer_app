import 'package:event_favorites_organizer/src/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable(createToJson: false)
class EventModel {
  final int id;
  final String title;
  final DateTime date;

  @AssetImageUrlConverter()
  @JsonKey(name: 'image_url')
  final String imageUrl;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.imageUrl,
  });

  factory EventModel.fromJson(JSON json) => _$EventModelFromJson(json);

  EventModel copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? imageUrl,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class AssetImageUrlConverter implements JsonConverter<String, String> {
  const AssetImageUrlConverter();

  @override
  String fromJson(String imageUrl) => 'assets/images/$imageUrl';

  @override
  String toJson(String assetPath) =>
      assetPath.replaceFirst('assets/images/', '');
}
