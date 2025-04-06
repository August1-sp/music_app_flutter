import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  @JsonKey(name: 'idAlbum')
  final String id;

  @JsonKey(name: 'strAlbum')
  final String name;

  @JsonKey(name: 'strArtist')
  final String artist;

  @JsonKey(name: 'strAlbumThumb')
  final String? thumbnailUrl;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    this.thumbnailUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}