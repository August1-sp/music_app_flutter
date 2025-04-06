import 'package:json_annotation/json_annotation.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
  @JsonKey(name: 'idTrack', defaultValue: '')
  final String id;
  
  @JsonKey(name: 'strTrack', defaultValue: '')
  final String title;
  
  @JsonKey(name: 'strArtist', defaultValue: '')
  final String artist;
  
  @JsonKey(name: 'strTrackThumb')
  final String? thumbnailUrl;

  Track({
    required this.id,
    required this.title,
    required this.artist,
    this.thumbnailUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}