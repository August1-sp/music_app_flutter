/*
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'hive_dataset.g.dart';

@HiveType(typeId: 0)
class Artist {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  Artist({required this.id, required this.name, required this.description});
}
class HiveDatabase {
  static const String _boxName = 'artists';
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ArtistAdapter());
    await Hive.openBox<Artist>(_boxName);
  }
  static Box<Artist> get artistsBox => Hive.box<Artist>(_boxName);
  static List<Artist> getAllArtists() {
    return artistsBox.values.toList();
  }
  static void addArtist(Artist artist) {
    artistsBox.put(artist.id, artist);
  }
  static void removeArtist(String artistId) {
    artistsBox.delete(artistId);
  }
  static bool isArtistExists(String artistId) {
    return artistsBox.containsKey(artistId);
  }
}
*/