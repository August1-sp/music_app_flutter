import 'package:json_annotation/json_annotation.dart';
import 'track.dart'; 
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

  @JsonKey(name: 'intScore')
  final double? score; 

  @JsonKey(name: 'intScoreVotes')
  final int? scoreVotes; 

  @JsonKey(name: 'strDescriptionEN')
  final String? descriptionEn;

  @JsonKey(name: 'strDescriptionFR')
  final String? descriptionFr;

  @JsonKey(ignore: true)
  final List<Track>? tracks;

  Album({
    required this.id,
    required this.name,
    required this.artist,
    this.thumbnailUrl,
    this.score,
    this.scoreVotes,
    this.descriptionEn,
    this.descriptionFr,
    this.tracks,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  String? get description => descriptionFr?.isNotEmpty == true ? descriptionFr : descriptionEn;
}
