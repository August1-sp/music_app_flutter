// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      id: json['idTrack'] as String? ?? '',
      title: json['strTrack'] as String? ?? '',
      artist: json['strArtist'] as String? ?? '',
      thumbnailUrl: json['strTrackThumb'] as String?,
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'idTrack': instance.id,
      'strTrack': instance.title,
      'strArtist': instance.artist,
      'strTrackThumb': instance.thumbnailUrl,
    };
