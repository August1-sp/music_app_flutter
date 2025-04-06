// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseApiResponse _$BaseApiResponseFromJson(Map<String, dynamic> json) =>
    BaseApiResponse(
      trending: json['trending'] as List<dynamic>?,
      album: (json['album'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      track: (json['track'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseApiResponseToJson(BaseApiResponse instance) =>
    <String, dynamic>{
      'trending': instance.trending,
      'album': instance.album?.map((e) => e.toJson()).toList(),
      'artists': instance.artists?.map((e) => e.toJson()).toList(),
      'track': instance.track?.map((e) => e.toJson()).toList(),
    };
