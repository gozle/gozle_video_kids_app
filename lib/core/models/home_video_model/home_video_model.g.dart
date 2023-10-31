// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeVideoModel _$HomeVideoModelFromJson(Map<String, dynamic> json) =>
    HomeVideoModel(
      image: json['thumbnail_url'] as String,
      pk: json['pk'] as int,
      title: json['title'] as String,
      duration: json['duration'] as int?,
      description: json['description'] as String,
      videoUrl: json['m3u8'] as String,
      view: json['view'] as int,
    );

Map<String, dynamic> _$HomeVideoModelToJson(HomeVideoModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'description': instance.description,
      'view': instance.view,
      'duration': instance.duration,
      'thumbnail_url': instance.image,
      'm3u8': instance.videoUrl,
    };
