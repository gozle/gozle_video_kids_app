import 'package:gozle_video_kids_v1/utilities/constants/end_points.dart';
import 'package:gozle_video_kids_v1/utilities/helpers/extensions.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home_video_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeVideoModel {
  final int pk;
  final String title;
  final String description;

  final int view;
  final int? duration;
  @JsonKey(includeFromJson: false)
  DateTime? date;
  @JsonKey(includeFromJson: false)
  double? aspect;
  @JsonKey(name: 'thumbnail_url')
  final String image;
  @JsonKey(name: 'm3u8')
  final String videoUrl;

  //?
  HomeVideoModel({
    required this.image,
    required this.pk,
    required this.title,
    this.aspect = 0.0,
    this.date,
    required this.duration,
    required this.description,
    required this.videoUrl,
    required this.view,
  });

  factory HomeVideoModel.fromJson(Map<String, dynamic> json) {
    //!
    final model = _$HomeVideoModelFromJson(json);
    final dateStr = (json[APIKeys.date] as String);
    final aspectList = (json[APIKeys.aspect] as String?)?.split(':');
    //!
    model.aspect = aspectList == null
        ? 16 / 9
        : aspectList.first.toInt / aspectList.last.toInt;
    model.date = DateTime.parse(dateStr);
    return model;
  }
  Map<String, dynamic> toJson() => _$HomeVideoModelToJson(this);
}
