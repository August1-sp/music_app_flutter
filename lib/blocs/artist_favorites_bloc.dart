import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/artist_favorites.dart';
enum ArtistFavoritesStatus { initial, loading, success, failure }
class ArtistFavoritesState {
  final List<FavoriteArtist> artists;
  final ArtistFavoritesStatus status;
  final String? error;
  const ArtistFavoritesState({
    this.artists = const [],
    this.status = ArtistFavoritesStatus.initial,
    this.error,
  });
}
class ArtistFavoritesBloc extends Cubit<ArtistFavoritesState> {
  final Box<FavoriteArtist> _favoritesBox;
  ArtistFavoritesBloc(this._favoritesBox) : super(const ArtistFavoritesState()) {
    loadFavorites();
  }
  Future<void> loadFavorites() async {
    emit(ArtistFavoritesState(status: ArtistFavoritesStatus.loading));
    try {
      final favorites = _favoritesBox.values.toList();
      emit(ArtistFavoritesState(
        artists: favorites,
        status: ArtistFavoritesStatus.success,
      ));
    } catch (e) {
      emit(ArtistFavoritesState(
        status: ArtistFavoritesStatus.failure,
        error: e.toString(),
      ));
    }
  }
  bool isFavorite(String artistId) {
    return _favoritesBox.values.any((artist) => artist.id == artistId);
  }
  Future<void> addFavorite(FavoriteArtist artist) async {
    try {
      await _favoritesBox.put(artist.id, artist);
      final favorites = _favoritesBox.values.toList();
      emit(ArtistFavoritesState(
        artists: favorites,
        status: ArtistFavoritesStatus.success,
      ));
    } catch (e) {
      emit(ArtistFavoritesState(
        status: ArtistFavoritesStatus.failure,
        error: e.toString(),
      ));
    }
  }
  Future<void> removeFavorite(String artistId) async {
    try {
      await _favoritesBox.delete(artistId);
      final favorites = _favoritesBox.values.toList();
      emit(ArtistFavoritesState(
        artists: favorites,
        status: ArtistFavoritesStatus.success,
      ));
    } catch (e) {
      emit(ArtistFavoritesState(
        status: ArtistFavoritesStatus.failure,
        error: e.toString(),
      ));
    }
  }
}