import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class Artist {
  @JsonKey(name: 'idArtist')
  final String id;

  @JsonKey(name: 'strArtist')
  final String name;

  @JsonKey(name: 'strArtistThumb')
  final String? thumbnailUrl;

  @JsonKey(name: 'strBiographyFR')
  final String? biographyFr;

  @JsonKey(name: 'strBiographyEN')
  final String? biographyEn;

  @JsonKey(name: 'strGenre')
  final String? genre;

  @JsonKey(name: 'strCountry')
  final String? country;

  Artist({
    required this.id,
    required this.name,
    this.thumbnailUrl,
    this.biographyFr,
    this.biographyEn,
    this.genre,
    this.country,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}