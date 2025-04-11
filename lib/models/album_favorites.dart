import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'album_favorites.g.dart';
@HiveType(typeId: 0)
@JsonSerializable()
class FavoriteArtist {
  @HiveField(0)
  @JsonKey(name: 'idArtist') 
  final String id;
  
  @HiveField(1)
  @JsonKey(name: 'strArtist')
  final String name;
  
  @HiveField(2)
  @JsonKey(name: 'strArtistThumb')
  final String? thumbnailUrl;
  FavoriteArtist({
    required this.id,
    required this.name,
    this.thumbnailUrl,
  });
  factory FavoriteArtist.fromJson(Map<String, dynamic> json) => 
      _$FavoriteArtistFromJson(json);
  
  Map<String, dynamic> toJson() => _$FavoriteArtistToJson(this);
}