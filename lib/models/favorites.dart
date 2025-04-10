/*
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'favorites.g.dart'; 

@HiveType(typeId: 0) 
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  Artist({required this.id, required this.name, required this.description});
}
class FavoritesRepository {
  final Box<Artist> _favoritesBox;
  FavoritesRepository(this._favoritesBox);
  List<Artist> getFavorites() {
    return _favoritesBox.values.toList();
  }
  void addFavorite(Artist artist) {
    _favoritesBox.put(artist.id, artist);
  }
  void removeFavorite(String artistId) {
    _favoritesBox.delete(artistId);
  }
  bool isFavorite(String artistId) {
    return _favoritesBox.containsKey(artistId);
  }
}
// BLoC pour gérer l'état des favoris
class FavoritesBloc with ChangeNotifier {
  final FavoritesRepository favoritesRepository;
  FavoritesBloc(this.favoritesRepository);
  List<Artist> get favorites => favoritesRepository.getFavorites();
  void toggleFavorite(Artist artist) {
    if (favoritesRepository.isFavorite(artist.id)) {
      favoritesRepository.removeFavorite(artist.id);
    } else {
      favoritesRepository.addFavorite(artist);
    }
    notifyListeners(); 
  }
  bool isFavorite(String artistId) {
    return favoritesRepository.isFavorite(artistId);
  }
}
// Initialisation de Hive
Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArtistAdapter()); 
  await Hive.openBox<Artist>('favorites'); 
}*/