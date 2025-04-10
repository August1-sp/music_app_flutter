// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['idAlbum'] as String,
      name: json['strAlbum'] as String,
      artist: json['strArtist'] as String,
      thumbnailUrl: json['strAlbumThumb'] as String?,
      score: (json['intScore'] as num?)?.toDouble(),
      scoreVotes: (json['intScoreVotes'] as num?)?.toInt(),
      descriptionEn: json['strDescriptionEN'] as String?,
      descriptionFr: json['strDescriptionFR'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'idAlbum': instance.id,
      'strAlbum': instance.name,
      'strArtist': instance.artist,
      'strAlbumThumb': instance.thumbnailUrl,
      'intScore': instance.score,
      'intScoreVotes': instance.scoreVotes,
      'strDescriptionEN': instance.descriptionEn,
      'strDescriptionFR': instance.descriptionFr,
    };
