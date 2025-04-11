import 'package:hive/hive.dart';

part 'artist_favorites.g.dart';

@HiveType(typeId: 0)
class FavoriteArtist {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? thumbnailUrl;
  FavoriteArtist({
    required this.id,
    required this.name,
    this.thumbnailUrl,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteArtist &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          thumbnailUrl == other.thumbnailUrl;
  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ thumbnailUrl.hashCode;
  FavoriteArtist copyWith({
    String? id,
    String? name,
    String? thumbnailUrl,
  }) {
    return FavoriteArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}