// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      id: json['idArtist'] as String,
      name: json['strArtist'] as String,
      thumbnailUrl: json['strArtistThumb'] as String?,
      biographyFr: json['strBiographyFR'] as String?,
      biographyEn: json['strBiographyEN'] as String?,
      genre: json['strGenre'] as String?,
      country: json['strCountry'] as String?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'idArtist': instance.id,
      'strArtist': instance.name,
      'strArtistThumb': instance.thumbnailUrl,
      'strBiographyFR': instance.biographyFr,
      'strBiographyEN': instance.biographyEn,
      'strGenre': instance.genre,
      'strCountry': instance.country,
    };
