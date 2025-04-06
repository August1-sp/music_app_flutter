import 'package:json_annotation/json_annotation.dart';
import 'album.dart';
import 'artist.dart';
import 'track.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BaseApiResponse {
  @JsonKey(name: 'trending')
  final List<dynamic>? trending;

  @JsonKey(name: 'album')
  final List<Album>? album;
  
  @JsonKey(name: 'artists')
  final List<Artist>? artists;
  
  @JsonKey(name: 'track')
  final List<Track>? track;

  BaseApiResponse({
    this.trending,
    this.album, 
    this.artists, 
    this.track,
  });

  List<Track>? get tracks {
    if (trending == null) return track;
    return trending
        ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  List<Album>? get albums {
    if (trending == null) return album;
    return trending
        ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  factory BaseApiResponse.fromJson(Map<String, dynamic> json) => 
      _$BaseApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseApiResponseToJson(this);
}